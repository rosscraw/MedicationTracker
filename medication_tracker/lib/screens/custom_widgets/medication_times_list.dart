import 'package:flutter/material.dart';
import 'package:medicationtracker/back_end/dose_time_details.dart';
import 'package:medicationtracker/back_end/medication_regime.dart';

/// List widget used on HomeScreen to generate lists for due and overdue medications.
class MedicationTimesList extends StatefulWidget {
  MedicationTimesList(this.medications);

  final List<DoseTimeDetails> medications;

  @override
  _MedicationTimesListState createState() => _MedicationTimesListState();
}

class _MedicationTimesListState extends State<MedicationTimesList> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 500.0,
      height: 200.0,
      child: ListView.builder(
          itemCount: widget.medications.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                leading: Icon(widget.medications[index]
                    .getMedicationRegime().getMedication()
                    .getMedicationIcon()),
                title:
                    Text(widget.medications[index].getMedicationRegime().getMedication().getName() + ': ' + widget.medications[index].getDoseTime().format(context) ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    // TODO fix functionality
                    Checkbox(
                      value: widget.medications[index]
                          .getHasMedBeenTaken(),
                      onChanged: (bool newValue) {
                        setState(() {
                          widget.medications[index]
                              .setHasMedBeenTaken(!widget.medications[index]
                                  .getHasMedBeenTaken());
                          widget.medications.removeAt(index);
                        });
                      },
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}