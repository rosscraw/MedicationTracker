import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicationtracker/back_end/dose_time_details.dart';
import 'package:medicationtracker/back_end/medication.dart';
import 'package:medicationtracker/back_end/medication_regime.dart';
import 'package:medicationtracker/back_end/user.dart';
import 'package:medicationtracker/screens/custom_widgets/medication_details_form.dart';
import 'package:medicationtracker/screens/custom_widgets/set_dosage_times.dart';
import 'package:provider/provider.dart';

/// Screen that allows user to input details about their Medication and adds it to their medication list.
class AddMedicationScreen extends StatefulWidget {
  @override
  _AddMedicationScreenState createState() => _AddMedicationScreenState();
}

class _AddMedicationScreenState extends State<AddMedicationScreen> {
//  String medicationName = '';
//  String medicationDosage = '';
//  String medicationUnit = '';
//  String medicationType = '';
//  List<TimeOfDay> dosageTimes = [];
//  final _medFormKey = GlobalKey<FormState>();
//  static List<String> _dosageUnits = ['mcg', 'mg', 'g', 'units', 'as required'];
//  var _currentItemSelected = _dosageUnits[0];

  MedicationRegime medicationRegime = new MedicationRegime();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

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
                    child: Column(
                      children: [
                        MedicationDetailsForm(isAddScreen: true, medicationRegime: medicationRegime),
                        // Medication Name Input.
//                            medicationNameForm(),
//                            // Medication dosage input.
//                            medicationDoseForm(),
//                            // Medication Type Input using a dropdown.
//                            medicationTypeForm(), //
                        // Dosage Timings List
//                            SetDosageTimes(medicationRegime: medicationRegime),
//                            SizedBox(height: 20.0),
//                            RaisedButton(
//                              shape: RoundedRectangleBorder(
//                                borderRadius: BorderRadius.circular(15.0),
//                              ),
//                              color: Colors.blue,
//                              child: Text(
//                                'Add Medication',
//                                style: TextStyle(color: Colors.white),
//                              ),
//                              // TODO add to medication to user's list.
//                              onPressed: () {
//                                addMedicationToList(
//                                    user,
//                                    medicationName,
//                                    medicationDosage,
//                                    medicationUnit,
//                                    medicationType);
//                                setState(() {});
//                              },
//                            )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        )));
  }

//  /// From for medication name input.
//  Widget medicationNameForm() {
//    return Column(
//      children: [
//        TextFormField(
//            validator: (val) =>
//                val.isEmpty ? "Please enter your medication's name" : null,
//            decoration: InputDecoration(
//              labelText: 'Medication Name',
//            ),
//            onChanged: (val) {
//              setState(() => medicationName = val);
//            }),
//        SizedBox(height: 20.0),
//      ],
//    );
//  }
//
//  /// Form for medication dose input.
//  /// Dropdown form for dosage units.
//  Widget medicationDoseForm() {
//    _dosageUnits.sort((a, b) => a.compareTo(b));
//
//    return Column(
//      children: [
//        Row(
//          children: [
//            Flexible(
//              child: TextFormField(
//                validator: (val) =>
//                    (!_currentItemSelected.contains('as required') &&
//                            val.isEmpty)
//                        ? "Please enter your medication's dosage"
//                        : null,
//                decoration: InputDecoration(
//                  contentPadding: EdgeInsets.all(0.0),
//                  labelText: 'Medication Dosage',
//                ),
//                onChanged: (val) {
//                  setState(() => medicationDosage = val);
//                },
//              ),
//            ),
//            Flexible(
//              child: DropdownButtonFormField<String>(
//                decoration: InputDecoration(
//                  labelText: 'Dosage Units',
//                  contentPadding: EdgeInsets.all(0.0),
//                ),
//                items: _dosageUnits.map((String dropDownStringItem) {
//                  return DropdownMenuItem<String>(
//                    value: dropDownStringItem,
//                    child: Text(dropDownStringItem),
//                  );
//                }).toList(),
//                onChanged: (String newValueSelected) {
//                  this._currentItemSelected = newValueSelected;
//                  setState(() {
//                    medicationUnit = newValueSelected;
//                  });
//                },
//              ),
//            ),
//          ],
//        ),
//        SizedBox(height: 20.0),
//      ],
//    );
//  }
//
//  /// Dropdown form for user to select medication type.
//  Widget medicationTypeForm() {
//    List<String> _medicationTypes = [
//      'Pills',
//      'Injection',
//      'Inhaled',
//      'Tablets',
//      'Other'
//    ];
//    _medicationTypes.sort((a, b) => a.toString().compareTo(b.toString()));
//    var _currentTypeSelected = _medicationTypes[0];
//
//    return Column(
//      children: [
//        DropdownButtonFormField<String>(
//          decoration: InputDecoration(
//            labelText: 'Medication Type',
//            contentPadding: EdgeInsets.all(0.0),
//          ),
//          items: _medicationTypes.map((String dropDownStringItem) {
//            return DropdownMenuItem<String>(
//              value: dropDownStringItem,
//              child: Text(dropDownStringItem),
//            );
//          }).toList(),
//          onChanged: (String newValueSelected) {
//            _currentTypeSelected = newValueSelected;
//            setState(() {
//              medicationType = newValueSelected;
//            });
//          },
//        ),
//        SizedBox(height: 20.0),
//      ],
//    );
//  }

//  /// Adds medication to user's medication list and returns the user to the Medication List screen.
//  void addMedicationToList(User user, String medicationName,
//      String medicationDosage, String medicationUnit, String medicationType) {
//    if (_medFormKey.currentState.validate()) {
//      setState(() {
//        Medication medication = new Medication(medicationName, medicationType);
//        if (_currentItemSelected != 'as required') {
//          medicationRegime.setMedication(medication);
//          medicationRegime.setDosage(medicationDosage + medicationUnit);
//          user.addMedication(medicationRegime);
//        } else {
//          medicationRegime.setMedication(medication);
//          medicationRegime.setDosage(medicationUnit);
//          user.addMedication(medicationRegime);
//        }
//        Navigator.pop(context);
//      });
//    }
//  }
}
