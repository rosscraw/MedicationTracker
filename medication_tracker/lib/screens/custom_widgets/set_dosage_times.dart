import 'package:flutter/material.dart';
import 'package:medicationtracker/screens/medication_list/add_medication_screen.dart';

class SetDosageTimes extends StatefulWidget {
  @override
  _SetDosageTimesState createState() => _SetDosageTimesState();
}

class _SetDosageTimesState extends State<SetDosageTimes> {
  List<TimeOfDay> dosageTimes = [];
  TimeOfDay chosenTime;
  int number = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        Text('Set Dosage Times'),
        ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: number,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                leading: setDeleteIcon(index),
                title: setTimeButton(index),
                trailing: setAddIcon(index),
              ),
            );
          },
        ),
      ],
    ));
  }

  /// Set the delete time icon for the dosage time card depending on its position in the list.
  InkWell setDeleteIcon(int index) {
    if (number - 1 == index && index > 0) {
      return InkWell(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.delete),
            Text('remove'),
          ],
        ),
        onTap: () {
          if (number > 1) {
            number--;
            if(dosageTimes.length == number) {
              dosageTimes.removeLast();
            }
          }
          setState(() {});
        },
      );
    } else {
      return null;
    }
  }

  /// Set the add time icon for the dosage time card depending on its position in the list.
  InkWell setAddIcon(int index) {
    if (number - 1 == index && dosageTimes.length == number) {
      return InkWell(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.add,
            ),
            Text('add')
          ],
        ),
        onTap: () {
          number++;
          setState(() {});
        },
      );
    } else {
      return null;
    }
  }

  /// Set the set time button for the dosage time card.
  InkWell setTimeButton(int index) {
    if (dosageTimes.length <= index) {
      return InkWell(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.alarm_add,
            ),
            Text('Add dosage time'),
          ],
        ),
        onTap: () async {
          selectDosageTime(context, index);
        },
      );
    } else {
      return InkWell(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.alarm_add),
            Text(dosageTimes[index].format(context)),
          ],
        ),
        onTap: () async {
          selectDosageTime(context, index);
        },
      );
    }
  }

  Future<Null> selectDosageTime(BuildContext context, int index) async {
    TimeOfDay chosenTime = await showTimePicker(
        context: context,
        initialTime: (TimeOfDay(hour: 12, minute: 0)),);

    setState(() {
      if(dosageTimes.length <= index && chosenTime!= null) {
        dosageTimes.add(chosenTime);
      }
      else if (chosenTime!= null){
        dosageTimes[index] = chosenTime;
      }
    });
  }

  List<TimeOfDay> getDosageTimes() {
    return dosageTimes;
  }
}
