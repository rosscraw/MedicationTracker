import 'package:flutter/material.dart';
import 'package:medicationtracker/models/dose_time_details.dart';

/// Controller for [MedicationTimesList] Widget.
class MedicationTimesListController {

  /// Get [Medication]'s [IconData]
  IconData getMedicationIcon(DoseTimeDetail medication) {
    return medication.getMedicationRegime()
        .getMedication()
        .getMedicationIcon();
  }

  /// Get Details about a [MedicationRegime]'s [Medication] name and [DoseTimeDetail] dose time.
  String getMedicationNameAndTime(DoseTimeDetail medication, BuildContext context) {
    return medication
        .getMedicationRegime()
        .getMedication()
        .getName() +
        ': ' +
        medication.getDoseTime().format(context);
  }

  /// Sets the [DoseTimeDetail] has been taken status of a [MedicationRegime] to the opposite of what it was.
  void setMedicationBeenTaken(DoseTimeDetail medication) {
    medication
        .setHasMedBeenTaken(!medication.getHasMedBeenTaken());
  }

  /// Removes [DoseTimeDetail] object from a due or overdue list when it has been checked off.
  void removeFromDueOrOverdueList(List<DoseTimeDetail> list, int index) {
    list.removeAt(index);
  }

}