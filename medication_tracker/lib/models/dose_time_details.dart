import 'package:flutter/material.dart';
import 'package:medicationtracker/models/medication.dart';

import 'medication_regime.dart';

class DoseTimeDetails {

  String timeId;
  TimeOfDay time;
  bool _hasMedBeenTaken;
  MedicationRegime _medication;

  /// Create new dose time detail using dose time.
  DoseTimeDetails({key, this.timeId, this.time}) {
    _hasMedBeenTaken = false;
  }


  String getDoseTimeId() {
    return timeId;
  }

  void setDoseTimeId(String doseTimeId) {
    timeId = doseTimeId;
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
    return _medication;
  }

  void setMedicationRegime(MedicationRegime med) {
    _medication = med;
  }
}