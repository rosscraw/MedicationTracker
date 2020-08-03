import 'package:flutter/material.dart';
import 'package:medicationtracker/controllers/medication_details_form_controller.dart';
import 'package:medicationtracker/models/medication.dart';
import 'package:medicationtracker/models/medication_regime.dart';
import 'package:medicationtracker/models/user.dart';
import 'package:medicationtracker/screens/custom_widgets/set_dosage_times.dart';
import 'package:medicationtracker/services/firestore_database.dart';
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
  MedicationDetailsFormController controller =
      new MedicationDetailsFormController();

  String _medicationName = '';
  String _medicationDosage = '';
  String _medicationUnit = '';
  String _medicationType = '';
  List<TimeOfDay> _dosageTimes = [];
  final _medFormKey = GlobalKey<FormState>();
  static List<String> _dosageUnits = ['mcg', 'mg', 'g', 'units', 'as required'];
  var _currentItemSelected = _dosageUnits[0];
  static List<String> _medicationTypes = [
    'Pills',
    'Injection',
    'Inhaled',
    'Tablets',
    'Other'
  ];


  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    FirestoreDatabase firestore = new FirestoreDatabase(uid: user.getUid());

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
          addOrEditButton(firestore, user);
          setState(() {});
        },
      )
    ]);
  }

  /// Initial State of variables
  @override
  void initState() {
    super.initState();
    _medicationName = controller.initialNameValue(
        widget.isAddScreen, widget.medicationRegime);

    _medicationType = controller.initialTypeValue(
        widget.isAddScreen, widget.medicationRegime);

    _medicationDosage = controller.initialDoseValue(widget.isAddScreen, widget.medicationRegime);

    _medicationUnit = controller.initialDoseUnitValue(widget.isAddScreen, widget.medicationRegime);

  }

  /// Form for medication name input.
  Widget medicationNameForm() {
    return Column(
      children: [
        TextFormField(
          onChanged: (val) {
            setState(() => _medicationName = val);
          },
          initialValue: controller.initialNameValue(
          widget.isAddScreen, widget.medicationRegime),
          validator: (val) =>
              val.isEmpty ? "Please enter your medication's name" : null,
          decoration: InputDecoration(
            labelText: 'Medication Name',
          ),
        ),
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
                initialValue: controller.initialDoseValue(widget.isAddScreen, widget.medicationRegime),
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
                value: controller.initialDoseUnitValue(widget.isAddScreen, widget.medicationRegime),
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



  /// Dropdown form for user to select medication type.
  Widget medicationTypeForm() {
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
          value: controller.initialTypeValue(widget.isAddScreen, widget.medicationRegime),
        ),
        SizedBox(height: 20.0),
      ],
    );
  }

  /// Adds a new medication to the user's list according to the information the user has input.
  void addMedicationToList(FirestoreDatabase firestore, User user, String medicationName,
      String medicationDosage, String medicationUnit, String medicationType) {
    widget.medicationRegime.getDosageTimings().forEach((element) {print(element.getDoseTime().toString());});
    if (_medFormKey.currentState.validate()) {
      setState(() {
        controller.addMedication(firestore,
            user,
            widget.medicationRegime,
            _currentItemSelected,
            medicationName,
            medicationDosage,
            medicationUnit,
            medicationType);
        Navigator.pop(context);
      });
    }
  }

  /// Edits the medication's details according to user input.
  void editMedicationDetails(FirestoreDatabase firestore,  User user, String medicationName,
      String medicationDosage, String medicationUnit, String medicationType) {
    if (_medFormKey.currentState.validate()) {
      setState(() {
        controller.editMedicationDetails(firestore,
            user,
            widget.medicationRegime,
            _currentItemSelected,
            medicationName,
            medicationDosage,
            medicationUnit,
            medicationType);
        Navigator.pop(context);
      });
    }
  }

  /// Determines whether the button should say add or edit medication.
  void addOrEditButton(FirestoreDatabase firestore, User user) {
    if (widget.isAddScreen) {
      addMedicationToList(firestore, user, _medicationName, _medicationDosage,
          _medicationUnit, _medicationType);
    } else {
      editMedicationDetails(firestore, user, _medicationName, _medicationDosage,
          _medicationUnit, _medicationType);
    }
  }
}
