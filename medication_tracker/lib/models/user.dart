import 'package:medicationtracker/models/medication.dart';

import 'medication_regime.dart';


/// Represents a User of the application.
class User {

  final String uid;
  String _email;
  String _name;
  List<MedicationRegime> _medications;

  User({this.uid, String name}) {
    setName(name);
    _medications = [];
  }

  String getName() {
    return _name;
  }

  void setName(String name) {
    _name = name;
  }

  String getUid() {
    return uid;
  }


  List<MedicationRegime> getMedicationList() {
    return _medications;
  }

  void setMedicationList(List<MedicationRegime> medicationList) {
    _medications = medicationList;
  }

  void addMedication(MedicationRegime medication) {
    if(_medications.contains(medication)) {
      String error = 'Medication already added to list and cannot be re-dded';
    }
    else {
      _medications.add(medication);
    }
  }

  String removeMedication(MedicationRegime medication) {
    if(_medications.contains(medication)) {
      _medications.remove(medication);
      return 'Medication Removed';
      }
    else {
      return 'Medication is not currently in list and cannot be removed';
    }
  }
}