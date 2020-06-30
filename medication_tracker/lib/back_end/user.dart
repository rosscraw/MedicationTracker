import 'package:medicationtracker/back_end/medication.dart';


/// Represents a User of the application.
class User {

  final String uid;
  String _email;
  String _name;
  List<Medication> _medications;

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

  List<Medication> getMedicationList() {
    return _medications;
  }

  void addMedication(Medication medication) {
    if(_medications.contains(medication)) {
      String error = 'Medication already added to list and cannot be re-dded';
    }
    else {
      _medications.add(medication);
    }
  }

  void removeMedication(Medication medication) {
    if(_medications.contains(medication)) {
      _medications.remove(medication);
      print('removed');
      _medications.forEach((element) {
        print(medication.getName());
      }
      );

      }
    else {
      String error = 'Medication is not currently in list and cannot be removed';
    }
  }
}