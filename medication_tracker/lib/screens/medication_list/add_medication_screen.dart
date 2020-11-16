import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicationtracker/models/dose_time_details.dart';
import 'package:medicationtracker/models/medication.dart';
import 'package:medicationtracker/models/medication_regime.dart';
import 'package:medicationtracker/models/user.dart';
import 'package:medicationtracker/screens/custom_widgets/medication_details_form.dart';
import 'package:medicationtracker/screens/custom_widgets/set_dosage_times.dart';
import 'package:provider/provider.dart';

/// Screen that allows [User] to input details about their [MedicationRegime] and adds it to their medication list.
class AddMedicationScreen extends StatefulWidget {
  @override
  _AddMedicationScreenState createState() => _AddMedicationScreenState();
}

class _AddMedicationScreenState extends State<AddMedicationScreen> {
  MedicationRegime medicationRegime = new MedicationRegime();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(title: Text('Add new Medication')),
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
                    child: MedicationDetailsForm(
                        isAddScreen: true, medicationRegime: medicationRegime),
                  ),
                )
              ],
            ),
          ),
        )));
  }
}
