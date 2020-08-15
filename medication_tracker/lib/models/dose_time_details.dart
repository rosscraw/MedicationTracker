import 'package:flutter/material.dart';
import 'package:medicationtracker/models/medication.dart';

import 'medication_regime.dart';

class DoseTimeDetail {

  String timeId;
  TimeOfDay time;
  bool _hasMedBeenTaken;
  MedicationRegime _medication;

  /// Create new [DoseTimeDetail] using [TimeOfDay] time.
  DoseTimeDetail({key, this.timeId, this.time}) {
    _hasMedBeenTaken = false;
  }


  /// Get the ID for the [DoseTimeDetail].
  String getDoseTimeId() {
    return timeId;
  }

  /// Set the ID for the [DoseTimeDetail].
  void setDoseTimeId(String doseTimeId) {
    timeId = doseTimeId;
  }

  /// Get the [TimeOfDay] time for the [DoseTimeDetail].
  TimeOfDay getDoseTime() {
    return time;
  }

  /// Set the [TimeOfDay] time for the [DoseTimeDetail].
  void setDoseTime(TimeOfDay doseTime) {
    time = doseTime;
  }

  /// Get the whether the [DoseTimeDetail] has been taken.
  bool getHasMedBeenTaken() {
    return _hasMedBeenTaken;
  }

  /// Set the whether the [DoseTimeDetail] has been taken.
  void setHasMedBeenTaken(bool hasBeenTaken) {
    _hasMedBeenTaken = hasBeenTaken;
  }


  /// Get the [MedicationRegime] the [DoseTimeDetail] belongs to.
  MedicationRegime getMedicationRegime() {
    return _medication;
  }

  /// Set the [MedicationRegime] the [DoseTimeDetail] belongs to.
  void setMedicationRegime(MedicationRegime med) {
    _medication = med;
  }
}