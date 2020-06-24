import 'package:medicationtracker/back_end/medication.dart';

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

  void addMedication(Medication medication) {
    _medications.add(medication);
  }

  void removeMedication(Medication medication) {
    _medications.remove(medication);
  }
}