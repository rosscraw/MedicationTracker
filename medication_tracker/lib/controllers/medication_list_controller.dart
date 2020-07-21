import 'package:medicationtracker/models/medication_regime.dart';
import 'package:medicationtracker/models/user.dart';
import 'package:flutter/material.dart';

class MedicationListController{

  /// Determines the initial state of the checkbox when screen is loaded.
  bool checkboxInitialState(int index, User user) {
    List<MedicationRegime> medicationList = user.getMedicationList();
    return medicationList[index].getAllMedsTaken();
  }

  /// Sets all medications within a regime to be taken.
  void setMedicationTaken(MedicationRegime medication) {
    medication.setAllMedsTaken(!medication.getAllMedsTaken());
  }

}