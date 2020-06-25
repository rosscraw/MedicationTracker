

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicationtracker/back_end/medication.dart';


/// Screen that displays the details of a single medication on a new screen.
/// Allows user to edit or delete information about the medication.
class MedicationDetails extends StatelessWidget {

  final Medication medication;

  MedicationDetails(this.medication);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(medication.getName())
      ),
      body: Text(medication.getDosage()),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Remove Medication',
        child: Icon(Icons.delete),
        backgroundColor: Colors.red,
      ),
    );
  }
}