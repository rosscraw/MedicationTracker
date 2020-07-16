import 'package:flutter/material.dart';
import 'package:medicationtracker/back_end/medication_regime.dart';
import 'package:medicationtracker/back_end/user.dart';
import 'package:provider/provider.dart';

class EditMedication extends StatefulWidget {
  final MedicationRegime medication;

  EditMedication(this.medication);

  @override
  _EditMedicationState createState() => _EditMedicationState();
}

class _EditMedicationState extends State<EditMedication> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit ' + widget.medication.getMedication().getName())
      ),
    );
  }
}