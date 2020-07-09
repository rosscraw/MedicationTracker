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
      appBar: AppBar(title: Text(widget.medication.getMedication().getName())),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Dosage: ' + widget.medication.getDosage(),
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              Text(
                'Type: ' + widget.medication.getMedication().getMedType(),
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              Text(
                'Timings:',
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
                            leading: Icon(Icons.alarm),
                            title: getDosageTime(index),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Checkbox(
                                  value: widget.medication
                                      .getDosageTimings()[index]
                                      .getHasMedBeenTaken(),
                                  onChanged: (bool newValue) {
                                    setState(() {
                                      widget.medication
                                          .getDosageTimings()[index]
                                          .setHasMedBeenTaken(!widget.medication
                                              .getDosageTimings()[index]
                                              .getHasMedBeenTaken());
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        // Delete Medication Button
        onPressed: () {
          // TODO Firestore Integration
          showDeleteAlert();
//          setState(() {
//            });
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
    String time = widget.medication
        .getDosageTimings()[index]
        .getDoseTime()
        .format(context);
    return Text(time);
  }

  /// Removes a medication from the user's list and update the Medication List Screen.
  void removeMedicationFromList() {
    widget.user.removeMedication(widget.medication);
  }

  /// Display an alert
  Future<void> showDeleteAlert() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Medication?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to delete this medication?'),
                Text('This will remove all reminders and dosage information forever!'),
              ],
            ),
          ),
          actions: <Widget>[
            new FlatButton(
                child: new Text("Continue"),
                onPressed: () {
                  setState(() {
                    removeMedicationFromList();
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  });
                }),
            new FlatButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
