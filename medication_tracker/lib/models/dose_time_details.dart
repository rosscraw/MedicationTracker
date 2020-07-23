import 'package:flutter/material.dart';
import 'package:medicationtracker/models/medication.dart';

import 'medication_regime.dart';

class DoseTimeDetails {

  final String tid;
  TimeOfDay time;
  bool _hasMedBeenTaken;
  MedicationRegime medication;

  /// Create new dose time detail using dose time.
  DoseTimeDetails({key, this.tid, this.time}) {
    _hasMedBeenTaken = false;
  }


  TimeOfDay getDoseTime() {
    return time;
  }

  void setDoseTime(TimeOfDay doseTime) {
    time = doseTime;
  }

  bool getHasMedBeenTaken() {
    return _hasMedBeenTaken;
  }

  void setHasMedBeenTaken(bool hasBeenTaken) {
    _hasMedBeenTaken = hasBeenTaken;
  }

  MedicationRegime getMedicationRegime() {
    return medication;
  }

  void setMedicationRegime(MedicationRegime med) {
    medication = med;
  }
}