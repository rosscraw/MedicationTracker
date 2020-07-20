import 'package:flutter/material.dart';
import 'package:medicationtracker/back_end/medication.dart';
import 'package:medicationtracker/back_end/medication_regime.dart';
import 'package:medicationtracker/back_end/user.dart';
import 'package:medicationtracker/screens/custom_widgets/set_dosage_times.dart';
import 'package:provider/provider.dart';

class MedicationDetailsForm extends StatefulWidget {
  MedicationDetailsForm({Key key, this.isAddScreen, this.medicationRegime})
      : super(key: key);

  final bool isAddScreen;
  final MedicationRegime medicationRegime;

  @override
  _MedicationDetailsFormState createState() => _MedicationDetailsFormState();
}

class _MedicationDetailsFormState extends State<MedicationDetailsForm> {
  String _medicationName = '';
  String _medicationDosage = '';
  String _medicationUnit = '';
  String _medicationType = '';
  List<TimeOfDay> _dosageTimes = [];
  final _medFormKey = GlobalKey<FormState>();
  static List<String> _dosageUnits = ['mcg', 'mg', 'g', 'units', 'as required'];
  var _currentItemSelected = _dosageUnits[0];

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return Column(children: <Widget>[
      Form(
          key: _medFormKey,
          child: Column(
            children: [
              medicationNameForm(),
              medicationDoseForm(),
              medicationTypeForm(),
            ],
          )),
      SetDosageTimes(
          medicationRegime: widget.medicationRegime,
          isAddScreen: widget.isAddScreen),
      SizedBox(height: 20.0),
      RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Text(
          widget.isAddScreen ? 'Add Medication' : 'Edit Medication',
          style: TextStyle(color: Colors.white),
        ),
        // TODO add to medication to user's list.
        onPressed: () {
          addOrEditButton(user);
          setState(() {});
        },
      )
    ]);
  }

  /// From for medication name input.
  Widget medicationNameForm() {
    return Column(
      children: [
        TextFormField(
            initialValue: initialNameValue(),
            validator: (val) =>
                val.isEmpty ? "Please enter your medication's name" : null,
            decoration: InputDecoration(
              labelText: 'Medication Name',
            ),
            onChanged: (val) {
              setState(() => _medicationName = val);
            }),
        SizedBox(height: 20.0),
      ],
    );
  }

  /// Form for medication dose input.
  /// Dropdown form for dosage units.
  Widget medicationDoseForm() {
    _dosageUnits.sort((a, b) => a.compareTo(b));

    return Column(
      children: [
        Row(
          children: [
            Flexible(
              child: TextFormField(
                validator: (val) =>
                    (!_currentItemSelected.contains('as required') &&
                            val.isEmpty)
                        ? "Please enter your medication's dosage"
                        : null,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(0.0),
                  labelText: 'Medication Dosage',
                ),
                onChanged: (val) {
                  setState(() => _medicationDosage = val);
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
                    _medicationUnit = newValueSelected;
                  });
                },
              ),
            ),
          ],
        ),
        SizedBox(height: 20.0),
      ],
    );
  }

  ///Initial name value in name form if user is editing a medication.
  String initialNameValue() {
    if (!widget.isAddScreen) {
      return widget.medicationRegime.getMedication().getName();
    } else {
      return null;
    }
  }

  //TODO figure out how to separate dose from unit
//  String initialDoseValue() {
//    if(!widget.isAddScreen) {
//      return widget.medicationRegime.getMedication().get();
//    }
//    else {
//      return null;
//    }
//  }

  ///Initial type value in type form if user is editing a medication.
  String initialTypeValue() {
    if (!widget.isAddScreen) {
      return widget.medicationRegime.getMedication().getMedType();
    } else {
      return null;
    }
  }

  /// Dropdown form for user to select medication type.
  Widget medicationTypeForm() {
    List<String> _medicationTypes = [
      'Pills',
      'Injection',
      'Inhaled',
      'Tablets',
      'Other'
    ];
    _medicationTypes.sort((a, b) => a.toString().compareTo(b.toString()));
    var _currentTypeSelected = _medicationTypes[0];

    return Column(
      children: [
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
            _currentTypeSelected = newValueSelected;
            setState(() {
              _medicationType = newValueSelected;
            });
          },
        ),
        SizedBox(height: 20.0),
      ],
    );
  }

  void addMedicationToList(User user, String medicationName,
      String medicationDosage, String medicationUnit, String medicationType) {
    if (_medFormKey.currentState.validate()) {
      setState(() {
        Medication medication = new Medication(medicationName, medicationType);
        if (_currentItemSelected != 'as required') {
          widget.medicationRegime.setMedication(medication);
          widget.medicationRegime.setDosage(medicationDosage + medicationUnit);
          user.addMedication(widget.medicationRegime);
        } else {
          widget.medicationRegime.setMedication(medication);
          widget.medicationRegime.setDosage(medicationUnit);
          user.addMedication(widget.medicationRegime);
        }
        Navigator.pop(context);
      });
    }
  }

  void editMedicationDetails(User user, String medicationName,
      String medicationDosage, String medicationUnit, String medicationType) {
    if (_medFormKey.currentState.validate()) {
      setState(() {
        Medication medication = widget.medicationRegime.getMedication();
        medication.setName(medicationName);
        medication.setMedType(medicationType);
        if (_currentItemSelected != 'as required') {
          widget.medicationRegime.setDosage(medicationDosage + medicationUnit);
        } else {
          widget.medicationRegime.setDosage(medicationUnit);
        }
        Navigator.pop(context);
      });
    }
  }

  void addOrEditButton(User user) {
    if (widget.isAddScreen) {
      addMedicationToList(user, _medicationName, _medicationDosage,
          _medicationUnit, _medicationType);
    } else {
      editMedicationDetails(user, _medicationName, _medicationDosage,
          _medicationUnit, _medicationType);
    }
  }
}
