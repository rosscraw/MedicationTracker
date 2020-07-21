import 'package:flutter/material.dart';
import 'package:medicationtracker/models/dose_time_details.dart';
import 'package:medicationtracker/models/medication_regime.dart';
import 'package:medicationtracker/screens/medication_list/add_medication_screen.dart';
import 'package:provider/provider.dart';

class SetDosageTimes extends StatefulWidget {

  //TODO make work with edit medication.
  final MedicationRegime medicationRegime;
  final bool isAddScreen;

  SetDosageTimes({Key key, this.medicationRegime, this.isAddScreen}) : super(key: key);




  @override
  _SetDosageTimesState createState() => _SetDosageTimesState(medicationRegime);
}

class _SetDosageTimesState extends State<SetDosageTimes> {

  _SetDosageTimesState(MedicationRegime medicationRegime) {
    this.medicationRegime = medicationRegime;
  }

  MedicationRegime medicationRegime;
  TimeOfDay chosenTime;
  int number = 1;
  List<TimeOfDay> dosageTimes = [];

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
            if (dosageTimes.length == number) {
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
    if (number - 1 == index &&  medicationRegime.getDosageTimings().length == number) {
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
    if ( medicationRegime.getDosageTimings().length <= index) {
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
            Text( medicationRegime.getDosageTimings()[index].getDoseTime().format(context)),
          ],
        ),
        onTap: () async {
          selectDosageTime(context, index);
        },
      );
    }
  }

  /// Set Dosage times using a time picker.
  Future<Null> selectDosageTime(
      BuildContext context, int index) async {
    TimeOfDay chosenTime = await showTimePicker(
      context: context,
      initialTime: (TimeOfDay(hour: 12, minute: 0)),
    );

    setState(() {
      if (medicationRegime.getDosageTimings().length <= index && chosenTime != null) {
        //dosageTimes.add(chosenTime);
        medicationRegime.addDoseTime(DoseTimeDetails(chosenTime));
      } else if (chosenTime != null) {
        medicationRegime.getDosageTimings()[index] = DoseTimeDetails(chosenTime);
      }
    });
  }

  void editScreenTimes() {
    if(!widget.isAddScreen) {

    }
  }
}
