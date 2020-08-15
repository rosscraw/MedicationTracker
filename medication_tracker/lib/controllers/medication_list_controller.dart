import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medicationtracker/models/medication.dart';
import 'package:medicationtracker/models/medication_regime.dart';
import 'package:medicationtracker/models/user.dart';
import 'package:flutter/material.dart';

class MedicationListController{
  List<MedicationRegime> medicationList = [];

  /// Determines the initial state of the checkbox when screen is loaded.
  bool checkboxInitialState(MedicationRegime medicationRegime) {
    return medicationRegime.getAllMedicationsTaken();
  }

  /// Sets all medications within a regime to be taken.
  void setMedicationTaken(MedicationRegime medication) {
    medication.setAllMedicationsTaken(!medication.getAllMedicationsTaken());
  }

}