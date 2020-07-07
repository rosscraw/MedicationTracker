import 'package:medicationtracker/back_end/medication.dart';
import 'dose_time_details.dart';

/// Class that represents a user's Medication, dosages and timings.
class MedicationRegime{

  Medication medication;
  String dosage;
  List<DoseTimeDetails> dosageTimings = [];

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

}