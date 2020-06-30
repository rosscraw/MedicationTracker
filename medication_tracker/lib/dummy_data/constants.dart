import 'package:medicationtracker/back_end/medication.dart';

class MedTrackerConstant {

  List<Medication> dummyMedsList = [
    new Medication("Creon", "150mg", "Capsule"),
    new Medication("Tresiba", "100 units", "Injection"),
    new Medication("Fiasp", "100 units", "Injection"),
    new Medication("Salbutamol", "100mcg", "Inhaler"),
    new Medication("Omeprazole", "20mg", "Capsule"),
  ];

  List<Medication> getDummyList() {
    return dummyMedsList;
  }

}
