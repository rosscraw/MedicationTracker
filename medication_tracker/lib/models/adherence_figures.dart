
import 'package:medicationtracker/models/medication_regime.dart';
import 'package:medicationtracker/models/user.dart';

import 'dose_time_details.dart';

class AdherenceFigures {
  int _total = 0;
  int _taken = 0;
  User user;
  List<MedicationRegime> medications;

  int getTakenMedications() {
    return _taken;
  }

  void setTakenMedications(int taken) {
    _taken = taken;
  }

  User getUser() {
    return user;
  }

  void setUser(User user) {
    this.user = user;
  }

  int getTotalMedications() {
    for (MedicationRegime medication in user.getMedicationList()) {
      for (DoseTimeDetails time in medication.dosageTimings) {
        _total++;
      }

    }
    return _total;
  }

  int getTotalTakenMedications() {
    for (MedicationRegime medication in user.getMedicationList()) {
      for (DoseTimeDetails time in medication.dosageTimings) {
        if(time.getHasMedBeenTaken()) {
          _taken++;
        }
      }

    }
    return _taken;
  }



}