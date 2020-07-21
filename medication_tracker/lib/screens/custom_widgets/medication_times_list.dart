import 'package:flutter/material.dart';
import 'package:medicationtracker/models/dose_time_details.dart';
import 'package:medicationtracker/models/medication_regime.dart';

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
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: widget.medications.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: Icon(widget.medications[index]
                  .getMedicationRegime()
                  .getMedication()
                  .getMedicationIcon()),
              title: Text(
                widget.medications[index]
                        .getMedicationRegime()
                        .getMedication()
                        .getName() +
                    ': ' +
                    widget.medications[index].getDoseTime().format(context),
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  // TODO fix functionality
                  Checkbox(
                    activeColor: Colors.green,
                    value: widget.medications[index].getHasMedBeenTaken(),
                    onChanged: (bool newValue) async {
                      checkboxState(index);

                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  /// Changes checkbox state depending on whether medication has been taken and removes from list.
  /// Small delay to allow checkbox animation to play.
  void checkboxState(int index) {
    setState(() {
      widget.medications[index]
          .setHasMedBeenTaken(!widget.medications[index].getHasMedBeenTaken());
      Future.delayed(Duration(milliseconds: 300), () {
        setState(() {
          widget.medications.removeAt(index);
          for(DoseTimeDetails time in widget.medications) {
            print(time.getMedicationRegime().getMedication().getName());

          }
          print('------');
        });
      });
    });
  }
}
