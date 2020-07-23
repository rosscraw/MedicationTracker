import 'package:flutter/cupertino.dart';
import 'package:medicationtracker/models/medication.dart';
import 'dose_time_details.dart';

/// Class that represents a user's Medication, dosages and timings.
class MedicationRegime{

  String medicationID;
  Medication medication;
  String dosage = '';
  String dosageUnits = '';
  List<DoseTimeDetails> dosageTimings = [];
  bool allMedsTaken = false;

  MedicationRegime({key, this.medicationID, this.medication, this.dosage, this.dosageUnits});

  Medication getMedication() {
    return medication;
  }

  void setMedication(Medication medication) {
    this.medication = medication;
  }

  String getMedicationID() {
    return medicationID;
  }

  void setMedicationID(String mid) {
    this.medicationID = mid;
  }

  String getDosage() {
    return dosage;
  }

  void setDosage(String dosage) {
    this.dosage = dosage;
  }

  String getDosageUnits() {
    return dosageUnits;
  }

  void setDosageUnits(String dosageUnits) {
    this.dosageUnits = dosageUnits;
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