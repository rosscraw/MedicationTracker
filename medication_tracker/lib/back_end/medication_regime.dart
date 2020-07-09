import 'package:flutter/cupertino.dart';
import 'package:medicationtracker/back_end/medication.dart';
import 'dose_time_details.dart';

/// Class that represents a user's Medication, dosages and timings.
class MedicationRegime{

  Medication medication;
  String dosage;
  List<DoseTimeDetails> dosageTimings = [];
  bool allMedsTaken = false;

  MedicationRegime(this.medication, this.dosage);

  Medication getMedication() {
    return medication;
  }

  String getDosage() {
    return dosage;
  }

  List<DoseTimeDetails> getDosageTimings() {
    return dosageTimings;
  }

  void addDoseTime(DoseTimeDetails time) {
    dosageTimings.add(time);
    int index = dosageTimings.indexOf(time);
    dosageTimings[index].setMedicationRegime(this);
  }

  void removeDoseTime(DoseTimeDetails time) {
    dosageTimings.remove(time);
  }

  bool getAllMedsTaken() {
    if(dosageTimings.length == 0) {
      return allMedsTaken;
    }
    else {
      int taken = 0;
      for (DoseTimeDetails time in dosageTimings) {
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
      for(DoseTimeDetails time in dosageTimings) {
        time.setHasMedBeenTaken(allTaken);
      }
      allMedsTaken = allTaken;
    }
  }

}