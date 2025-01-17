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

  /// Set the [Medication] for the [MedicationRegime].
  void setMedication(Medication medication) {
    this.medication = medication;
  }

  /// [MedicationRegime]'s ID for [FirestoreDatabase].
  String getMedicationID() {
    return medicationID;
  }

  /// Set the [MedicationRegime]'s ID.
  void setMedicationID(String mid) {
    this.medicationID = mid;
  }

  /// The dosage of this regime.
  String getDosage() {
    return dosage;
  }

  /// Set the dosage.
  void setDosage(String dosage) {
    this.dosage = dosage;
  }

  /// The units of dosage for this regime.
  String getDosageUnits() {
    return dosageUnits;
  }

  /// Set the dosage units.
  void setDosageUnits(String dosageUnits) {
    this.dosageUnits = dosageUnits;
  }

  /// List of [DoseTimeDetail] doses for the regime.
  List<DoseTimeDetail> getDosageTimings() {
    return dosageTimings;
  }

  /// Adds a [DoseTimeDetail] time to the list.
  void addDoseTime(DoseTimeDetail time) {
    if(dosageTimings.contains(time)) {
      print("Time already in list");
    }
    else {
      dosageTimings.add(time);
      int index = dosageTimings.indexOf(time);
      dosageTimings[index].setMedicationRegime(this);
    }
  }

  /// Removes a [DoseTimeDetail] time from the list.
  void removeDoseTime(DoseTimeDetail time) {
    dosageTimings.remove(time);
  }

  /// Get whether all doses in a [MedicationRegime] have been taken.
  bool getAllMedicationsTaken() {
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

  /// Set that all doses have been taken for a [MedicationRegime].
  /// If the [MedicationRegime] has [DoseTimeDetail]s these are also individually set.
  void setAllMedicationsTaken(bool allTaken) {
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