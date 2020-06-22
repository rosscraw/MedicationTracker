

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicationtracker/back_end/medication.dart';

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