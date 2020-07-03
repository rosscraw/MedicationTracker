import 'package:medicationtracker/back_end/medication.dart';

/// Class that represents a user's Medication, dosages and timings.
class MedicationRegime{

  Medication medication;
  int dosage;
  List<DateTime> dosageTimings;

  MedicationRegime(this.medication, this.dosage);

  void addDosageTime(DateTime time) {
    dosageTimings.add(time);
  }

}