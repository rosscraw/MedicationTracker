import 'package:flutter/material.dart';

class DoseTimeDetails {

  TimeOfDay time;
  bool _hasMedBeenTaken = false;

  /// Create new dose time detail using dose time.
  DoseTimeDetails(this.time);

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
}