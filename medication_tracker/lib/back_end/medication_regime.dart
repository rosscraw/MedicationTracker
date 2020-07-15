import 'package:flutter/cupertino.dart';
import 'package:medicationtracker/back_end/medication.dart';
import 'dose_time_details.dart';

/// Class that represents a user's Medication, dosages and timings.
class MedicationRegime extends ChangeNotifier{

  Medication medication;
  String dosage = '';
  List<DoseTimeDetails> dosageTimings = [];
  bool allMedsTaken = false;

  MedicationRegime({key, this.medication, this.dosage});

  Medication getMedication() {
    return medication;
  }

  void setMedication(Medication medication) {
    this.medication = medication;
  }

  String getDosage() {
    return dosage;
  }

  void setDosage(String dosage) {
    this.dosage = dosage;
  }

  List<DoseTimeDetails> getDosageTimings() {
    return dosageTimings;
  }

  void addDoseTime(DoseTimeDetails time) {
    dosageTimings.add(time);
    int index = dosageTimings.indexOf(time);
    dosageTimings[index].setMedicationRegime(this);
    notifyListeners();
  }

  void removeDoseTime(DoseTimeDetails time) {
    dosageTimings.remove(time);
    notifyListeners();
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