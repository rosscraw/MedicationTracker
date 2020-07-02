import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicationtracker/back_end/medication.dart';
import 'package:medicationtracker/back_end/user.dart';


/// Screen that displays the details of a single medication on a new screen.
/// Allows user to edit or delete information about the medication.
class MedicationDetails extends StatefulWidget {

  final Medication medication;
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
        title: Text(widget.medication.getName())
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
              Text('Type: ' + widget.medication.getMedType(),
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton( // Delete Medication Button
        onPressed: () {
          // TODO Firestore Integration
          setState(() {
            widget.user.removeMedication(widget.medication);
            Navigator.pop(context);
            });
          },
        tooltip: 'Remove Medication',
        child: Icon(Icons.delete),
        backgroundColor: Colors.red,
      ),
    );
  }
}