
import 'package:medicationtracker/models/medication_regime.dart';
import 'package:medicationtracker/models/user.dart';

import 'dose_time_details.dart';

class AdherenceFigures {
  int _total = 0;
  int _taken = 0;
  User user;
  List<MedicationRegime> medications;

  int getTakenMeds() {
    return _taken;
  }

  void setTakenMeds(int taken) {
    _taken = taken;
  }

  int getTotalMeds() {
    for (MedicationRegime medication in user.getMedicationList()) {
      for (DoseTimeDetails time in medication.dosageTimings) {
        _total++;      }

    }
    return _total;
  }

}