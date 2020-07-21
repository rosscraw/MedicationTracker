import 'package:flutter/material.dart';
import 'package:medicationtracker/models/dose_time_details.dart';

class MedicationTimesListController {

  /// Get [Medication]'s [IconData]
  IconData getMedicationIcon(DoseTimeDetails medication) {
    return medication.getMedicationRegime()
        .getMedication()
        .getMedicationIcon();
  }

  /// Get Details about a [MedicationRegime]'s [Medication] name and [DoseTimeDetails] dose time.
  String getMedicationNameAndTime(DoseTimeDetails medication, BuildContext context) {
    return medication
        .getMedicationRegime()
        .getMedication()
        .getName() +
        ': ' +
        medication.getDoseTime().format(context);
  }

  /// Sets the [DoseTimeDetails] has been taken status of a [MedicationRegime] to the opposite of what it was.
  void setMedicationBeenTaken(DoseTimeDetails medication) {
    medication
        .setHasMedBeenTaken(!medication.getHasMedBeenTaken());
  }

  /// Removes [DoseTimeDetails] object from a due or overdue list when it has been checked off.
  void removeFromDueOrOverdueList(List<DoseTimeDetails> list, int index) {
    list.removeAt(index);
  }

}