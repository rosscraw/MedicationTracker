import 'package:flutter/material.dart';
import 'package:medicationtracker/controllers/set_dosage_times_controller.dart';
import 'package:medicationtracker/models/dose_time_details.dart';
import 'package:medicationtracker/models/medication_regime.dart';
import 'package:medicationtracker/screens/medication_list/add_medication_screen.dart';
import 'package:provider/provider.dart';

class SetDosageTimes extends StatefulWidget {
  //TODO make work with edit medication.
  final MedicationRegime medicationRegime;
  final bool isAddScreen;

  SetDosageTimes({Key key, this.medicationRegime, this.isAddScreen})
      : super(key: key);

  @override
  _SetDosageTimesState createState() => _SetDosageTimesState(medicationRegime);
}

class _SetDosageTimesState extends State<SetDosageTimes> {
  _SetDosageTimesState(MedicationRegime medicationRegime) {
    this.medicationRegime = medicationRegime;
  }

  SetDosageTimesController controller = new SetDosageTimesController();

  MedicationRegime medicationRegime;
  TimeOfDay chosenTime;
  int initialListLength = 1;
  List<TimeOfDay> dosageTimes = [];


  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        Text('Set Dosage Times'),
        widget.isAddScreen ? addScreenTimesList() : editScreenTimesList(),

//        ListView.builder(
//          scrollDirection: Axis.vertical,
//          shrinkWrap: true,
//          itemCount: number,
//          itemBuilder: (context, index) {
//            return Card(
//              child: ListTile(
//                leading: setDeleteIcon(index),
//                title: setTimeButton(index),
//                trailing: setAddIcon(index),
//              ),
//            );
//          },
//        ),
      ],
    ));
  }

  /// Set the delete time icon for the dosage time card depending on its position in the list.
  InkWell setDeleteIcon(int index) {
    if (medicationRegime.getDosageTimings().length == index + 1 && index > 0 && index == initialListLength - 1) {
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
          initialListLength--;
          if (medicationRegime.getDosageTimings().length > 1) {
              medicationRegime.getDosageTimings().removeLast();
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
    if (medicationRegime.getDosageTimings().length == index + 1 && index == initialListLength - 1) {
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
          initialListLength++;
          setState(() {});
        },
      );
    } else {
      return null;
    }
  }

  /// Set the set time button for the dosage time card.
  InkWell setTimeButton(int index) {
    if (medicationRegime.getDosageTimings().length <= index) {
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
            Text(medicationRegime
                .getDosageTimings()[index]
                .getDoseTime()
                .format(context)),
          ],
        ),
        onTap: () async {
          selectDosageTime(context, index);
        },
      );
    }
  }

  /// Set Dosage times using a time picker.
  Future<Null> selectDosageTime(BuildContext context, int index) async {
    TimeOfDay chosenTime = await showTimePicker(
      context: context,
      initialTime: (TimeOfDay(hour: 12, minute: 0)),
    );

    setState(() {
      if (medicationRegime.getDosageTimings().length <= index &&
          chosenTime != null) {
        //dosageTimes.add(chosenTime);
        medicationRegime.addDoseTime(DoseTimeDetails(time: chosenTime));
      } else if (chosenTime != null) {
        medicationRegime.getDosageTimings()[index] =
            DoseTimeDetails(time: chosenTime);
      }
    });
  }

  /// ListView for user to add medication times.
  ListView addScreenTimesList() {
    if (widget.isAddScreen) {
      return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: initialListLength,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: setDeleteIcon(index),
              title: setTimeButton(index),
              trailing: setAddIcon(index),
            ),
          );
        },
      );
    } else {
      return null;
    }
  }

  /// ListView containing dose times previously set for the edit medication screen.
  ListView editScreenTimesList() {
    if (initialListLength == 1) {
      initialListLength = widget.medicationRegime
          .getDosageTimings()
          .length;
    }
    if (!widget.isAddScreen) {
      return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: initialListLength,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: setDeleteIcon(index),
              title: setTimeButton(index),
              trailing: setAddIcon(index),
            ),
          );
        },
      );
    } else {
      return null;
    }
  }
}
