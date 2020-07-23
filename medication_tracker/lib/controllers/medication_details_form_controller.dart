import 'package:medicationtracker/models/medication.dart';
import 'package:medicationtracker/models/medication_regime.dart';
import 'package:medicationtracker/models/user.dart';
import 'package:medicationtracker/screens/home/home_widget.dart';
import 'package:medicationtracker/services/firebase_authentication.dart';
import 'package:medicationtracker/services/firestore_database.dart';
import'package:provider/provider.dart';

/// Controller for the Medication Details Form Widget.
class MedicationDetailsFormController {


  /// Adds Medication to user's list.
  void addMedication(FirestoreDatabase firestore,
      User user,
      MedicationRegime medicationRegime,
      String currentItem,
      String medicationName,
      String medicationDosage,
      String medicationUnit,
      String medicationType) {
    Medication medication = new Medication(medicationName, medicationType);
    if (currentItem != 'as required') {
      medicationRegime.setMedication(medication);
      medicationRegime.setDosage(medicationDosage);
      medicationRegime.setDosageUnits(medicationUnit);
      user.addMedication(medicationRegime);
    } else {
      medicationRegime.setMedication(medication);
      medicationRegime.setDosageUnits(medicationUnit);
      user.addMedication(medicationRegime);
    }
    medicationRegime.setMedicationID(user.uid + medicationName);
    firestore.addMedication(medicationRegime);

  }

  /// Edit a Medication Regime's details.
  void editMedicationDetails(FirestoreDatabase firestore,
      User user,
      MedicationRegime medicationRegime,
      String currentItem,
      String medicationName,
      String medicationDosage,
      String medicationUnit,
      String medicationType) {
    Medication medication = medicationRegime.getMedication();
    medication.setName(medicationName);
    medication.setMedType(medicationType);

    if (currentItem != 'as required') {
      medicationRegime.setDosage(medicationDosage);
      medicationRegime.setDosageUnits(medicationUnit);
    } else {
      medicationRegime.setDosageUnits(medicationUnit);
    }
    firestore.editMedication(medicationRegime);
  }

  ///Initial name value in name form if user is editing a medication.
  String initialNameValue(bool isAddScreen, MedicationRegime medicationRegime) {
    if (!isAddScreen) {
      return medicationRegime.getMedication().getName();
    } else {
      return null;
    }
  }

  ///Initial dose value in dose form if user is editing a medication.
  String initialDoseValue(bool isAddScreen, MedicationRegime medicationRegime) {
    if (!isAddScreen) {
      return medicationRegime.getDosage();
    } else {
      return '';
    }
  }

  /// Initial dose unit value in dose form if user is editing a medication.
  String initialDoseUnitValue(
      bool isAddScreen, MedicationRegime medicationRegime) {
    if (!isAddScreen) {
      return medicationRegime.getDosageUnits();
    } else {
      return null;
    }
  }

  ///Initial type value in type form if user is editing a medication.
  String initialTypeValue(bool isAddScreen, MedicationRegime medicationRegime) {
    if (!isAddScreen) {
      return medicationRegime.getMedication().getMedType();
    } else {
      return null;
    }
  }


}
