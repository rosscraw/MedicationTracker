
import 'package:medicationtracker/models/medication_regime.dart';
import 'package:medicationtracker/models/user.dart';

import 'dose_time_details.dart';

/// Class that represents the details required to monitor adherence figures.
class AdherenceFigures {
  int _total = 0;
  int _taken = 0;
  User user;
  List<MedicationRegime> medications;

  /// Returns the [User]
  User getUser() {
    return user;
  }

  /// Sets the [User]
  void setUser(User user) {
    this.user = user;
  }

  /// Gets the total number of [DoseTimeDetail]s in a [User]'s list of [MedicationRegime]s.
  int getTotalMedications() {
    for (MedicationRegime medication in user.getMedicationList()) {
      if (medication.getDosageTimings().isEmpty) {
        _total++;
      }
      else {
        for (DoseTimeDetail time in medication.dosageTimings) {
          _total++;
        }
      }

    }
    return _total;
  }

  /// Gets the total number of [DoseTimeDetail]s in a [User]'s list of [MedicationRegime]s that have been taken.
  int getTotalTakenMedications() {
    for (MedicationRegime medication in user.getMedicationList()) {
      if (medication.getDosageTimings().isEmpty && medication.getAllMedicationsTaken()) {
        _taken++;
      }
      else {
        for (DoseTimeDetail time in medication.dosageTimings) {
          if (time.getHasMedBeenTaken()) {
            _taken++;
          }
        }
      }

    }
    return _taken;
  }



}