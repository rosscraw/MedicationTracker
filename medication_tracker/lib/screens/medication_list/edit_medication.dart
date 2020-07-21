import 'package:flutter/material.dart';
import 'package:medicationtracker/models/medication_regime.dart';
import 'package:medicationtracker/models/user.dart';
import 'package:medicationtracker/screens/custom_widgets/medication_details_form.dart';
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
        body: SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 50.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10.0,
                    ),
                    Center(
                      child: SizedBox(
                        width: 300.0,
                        child: Column(
                          children: [
                            MedicationDetailsForm(isAddScreen: false, medicationRegime: widget.medication),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ))
    );
  }
}