import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:medicationtracker/models/dose_time_details.dart';
import 'package:medicationtracker/models/medication.dart';
import 'package:medicationtracker/models/medication_regime.dart';
import 'package:medicationtracker/models/user.dart';
import 'package:medicationtracker/assets/icons/icons.dart';

/// Integration testing of system.
void main() {

  User user = new User(uid: '1234', name: 'Ross');
  Medication medication1 = new Medication('Symkevi', 'Tablets');
  MedicationRegime medicationRegime1 = new MedicationRegime(medication: medication1, dosage: '100', dosageUnits: 'mg');
  Medication medication2 = new Medication('Kalydeco', 'Tablets');
  MedicationRegime medicationRegime2 = new MedicationRegime(medication: medication2, dosage: '150', dosageUnits: 'mg');
  TimeOfDay time1 = new TimeOfDay(hour: 12, minute: 0);
  DoseTimeDetail doseTimeDetail1 = new DoseTimeDetail(time: time1);
  TimeOfDay time2 = new TimeOfDay(hour: 16, minute: 0);
  DoseTimeDetail doseTimeDetail2 = new DoseTimeDetail(time: time2);

  test("Test adding medications and dose times to User", (){
    medicationRegime1.addDoseTime(doseTimeDetail1);
    medicationRegime1.addDoseTime(doseTimeDetail2);
    user.addMedication(medicationRegime1);
    user.addMedication(medicationRegime2);
    expect(user.getMedicationList().length, equals(2));
    expect(user.getMedicationList()[0], equals(medicationRegime1));
    expect(user.getMedicationList()[1], equals(medicationRegime2));
    expect(user.getMedicationList()[0].getDosageTimings().length, equals(2));
    expect(user.getMedicationList()[1].getDosageTimings().length, equals(0));

  });

  test("Test setting medication's being taken", (){
    user.getMedicationList()[1].setAllMedicationsTaken(true);
    user.getMedicationList()[0].getDosageTimings()[0].setHasMedBeenTaken(true);
    user.getMedicationList()[0].getDosageTimings()[1].setHasMedBeenTaken(true);
    expect(user.getMedicationList()[0].getAllMedicationsTaken(), equals(true));
    expect(user.getMedicationList()[1].getAllMedicationsTaken(), equals(true));
  });

  test("Test that when one of two doses for a medication have been taken that all taken is false", () {
    user.getMedicationList()[0].getDosageTimings()[1].setHasMedBeenTaken(false);
    expect(user.getMedicationList()[0].getAllMedicationsTaken(), equals(false));
  });
}