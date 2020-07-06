import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicationtracker/back_end/medication.dart';
import 'package:medicationtracker/back_end/user.dart';
import 'package:medicationtracker/back_end/medication_regime.dart';

/// Screen that displays the details of a single medication on a new screen.
/// Allows user to edit or delete information about the medication.
class MedicationDetails extends StatefulWidget {

  final MedicationRegime medication;
  final User user;

  MedicationDetails(this.medication, this.user);

  @override
  _MedicationDetailsState createState() => _MedicationDetailsState();
}

class _MedicationDetailsState extends State<MedicationDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.medication.getMedication().getName())
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Dosage: ' + widget.medication.getDosage(),
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              Text('Type: ' + widget.medication.getMedication().getMedType(),
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              Text('Timings:',
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
//              // TODO list tile
//              for ( var item in widget.medication.getDosageTimings() )
//                Text(item.getDoseTime().toString()),
              SizedBox(
                width: 500.0,
                height: 250.0,
                child: Container(
                  child: ListView.builder(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 50),
                      itemCount: widget.medication.getDosageTimings().length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            leading: Icon(
                              Icons.alarm
                            ),
                            title: getDosageTime(index),
                          ),
                        );
                      }
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended( // Delete Medication Button
        onPressed: () {
          // TODO Firestore Integration
          setState(() {
            widget.user.removeMedication(widget.medication);
            Navigator.pop(context);
            });
          },
        label: Text('Delete Medication'),
        tooltip: 'Delete Medication',
        icon: Icon(Icons.delete),
        backgroundColor: Colors.red,
      ),
    );
  }

  /// Get text for dosage timings list.
  Text getDosageTime(int index) {
    String time = widget.medication.getDosageTimings()[index].getDoseTime().format(context);
    return Text(time);
  }
}