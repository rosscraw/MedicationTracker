import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicationtracker/back_end/medication.dart';
import 'package:medicationtracker/back_end/user.dart';


/// Screen that allows user to input details about their Medication and adds it to their medication list.
class AddMedicationScreen extends StatefulWidget {

  final User user;

  AddMedicationScreen(this.user);

  @override
  _AddMedicationScreenState createState() => _AddMedicationScreenState();
}

class _AddMedicationScreenState extends State<AddMedicationScreen> {
  String medicationName = '';
  String medicationDosage = '';
  String medicationUnit = '';
  String medicationType = '';
  final _medFormKey = GlobalKey<FormState>();
  static List<String> _dosageUnits = [
    'mcg',
    'mg',
    'g',
    'units',
    'as required'
  ];
  var _currentItemSelected = _dosageUnits[0];
  static List<String> _medicationTypes = [
    'Pills',
    'Injection',
    'Inhaled',
    'Other'
  ];
  var _currentTypeSelected = _medicationTypes[0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Add new Medication')
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
                    child: Form (
                      key: _medFormKey,
                      child: Column(
                        children: [
                          // Medication Name Input.
                          TextFormField(
                              validator: (val) => val.isEmpty ? "Please enter your medication's name" : null,
                              decoration: InputDecoration(
                                labelText: 'Medication Name',
                              ),
                              onChanged: (val) {
                                setState(() => medicationName = val);
                              }
                          ),
                          SizedBox(height: 20.0),
                          // Medication dosage input.
                          // Dropdown option to select units of dosage.
                          Row(
                            children: [
                              Flexible(
                                child: TextFormField(
                                    validator: (val) => (!_currentItemSelected.contains('as required') && val.isEmpty) ? "Please enter your medication's dosage" : null,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(0.0),
                                      labelText: 'Medication Dosage',
                                    ),
                                    onChanged: (val) {
                                      setState(() => medicationDosage = val);
                                    },
                                ),
                              ),
                              Flexible(
                                child: DropdownButtonFormField<String>(
                                  decoration: InputDecoration(
                                    labelText: 'Dosage Units',
                                    contentPadding: EdgeInsets.all(0.0),
                                  ),
                                  items: _dosageUnits.map((String dropDownStringItem) {
                                    return DropdownMenuItem<String>(
                                      value: dropDownStringItem,
                                      child: Text(dropDownStringItem),
                                    );
                                  }).toList(),
                                  onChanged: (String newValueSelected) {
                                    this._currentItemSelected = newValueSelected;
                                    setState(() {
                                      medicationUnit = newValueSelected;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20.0),
                          // Medication Type Input using a dropdown.
                          DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              labelText: 'Medication Type',
                              contentPadding: EdgeInsets.all(0.0),
                            ),
                            items: _medicationTypes.map((String dropDownStringItem) {
                              return DropdownMenuItem<String>(
                                value: dropDownStringItem,
                                child: Text(dropDownStringItem),
                              );
                            }).toList(),
                            onChanged: (String newValueSelected) {
                              this._currentTypeSelected = newValueSelected;
                              setState(() {
                                medicationType = newValueSelected;
                              });
                            },
                          ),
                          SizedBox(height: 20.0),
                          RaisedButton(
                            color: Colors.blue,
                            child: Text(
                              'Add Medication',
                              style: TextStyle(color: Colors.white),
                            ),
                            // TODO add to medication to user's list.
                            onPressed: () {
                              addMedicationToList(medicationName, medicationDosage, medicationUnit, medicationType);
                            },
                          )
                        ],
                      )
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      )
    );
  }

  /// Adds medication to user's medication list and returns the user to the Medication List screen.
  void addMedicationToList(String medicationName, String medicationDosage, String medicationUnit, String medicationType) {
    if(_medFormKey.currentState.validate()) {
      setState(() {
        if (_currentItemSelected != 'as required') {
          widget.user.addMedication(new Medication(medicationName, (medicationDosage + medicationUnit), medicationType));
        }
        else {
          widget.user.addMedication(new Medication(medicationName, (medicationUnit), ''));
        }
        Navigator.pop(context);
      });
    }
  }
}
