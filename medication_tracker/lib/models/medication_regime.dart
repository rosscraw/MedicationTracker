import 'package:flutter/cupertino.dart';
import 'package:medicationtracker/models/medication.dart';
import 'dose_time_details.dart';

/// Class that represents a [User]'s [Medication], dosages and timings.
class MedicationRegime{


  String medicationID;
  Medication medication;

  String dosage = '';

  String dosageUnits = '';

  List<DoseTimeDetail> dosageTimings = [];

  bool allMedsTaken = false;

  MedicationRegime({key, this.medicationID, this.medication, this.dosage, this.dosageUnits});

  /// The [Medication] the regime is for.
  Medication getMedication() {
    return medication;
  }

  void setMedication(Medication medication) {
    this.medication = medication;
  }

  /// Medication Regime's ID for [FirestoreDatabase].
  String getMedicationID() {
    return medicationID;
  }

  void setMedicationID(String mid) {
    this.medicationID = mid;
  }

  /// The dosage of this regime.
  String getDosage() {
    return dosage;
  }

  void setDosage(String dosage) {
    this.dosage = dosage;
  }

  /// The units of dosage for this regime.
  String getDosageUnits() {
    return dosageUnits;
  }

  void setDosageUnits(String dosageUnits) {
    this.dosageUnits = dosageUnits;
  }

  /// List of [DoseTimeDetail] doses for the regime.
  List<DoseTimeDetail> getDosageTimings() {
    return dosageTimings;
  }

  /// Adds a [DoseTimeDetail] time to the list.
  void addDoseTime(DoseTimeDetail time) {
    dosageTimings.add(time);
    int index = dosageTimings.indexOf(time);
    dosageTimings[index].setMedicationRegime(this);
  }

  /// Removes a [DoseTimeDetail] time from the list.
  void removeDoseTime(DoseTimeDetail time) {
    dosageTimings.remove(time);
  }

  /// Whether all doses in this regime have been taken.
  bool getAllMedsTaken() {
    if(dosageTimings.length == 0) {
      return allMedsTaken;
    }
    else {
      int taken = 0;
      for (DoseTimeDetail time in dosageTimings) {
        if(time.getHasMedBeenTaken()) {
          taken++;
        }
      }
      if (taken == dosageTimings.length) {
        allMedsTaken = true;
      }
      else {
        allMedsTaken = false;
      }
      return allMedsTaken;
    }
  }

  void setAllMedsTaken(bool allTaken) {
    // Medications with no time set.
    if(dosageTimings.length == 0) {
      allMedsTaken = allTaken;
    }
    else {
      for(DoseTimeDetail time in dosageTimings) {
        time.setHasMedBeenTaken(allTaken);
      }
      allMedsTaken = allTaken;
    }
  }

}