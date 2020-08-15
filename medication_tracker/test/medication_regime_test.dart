import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:medicationtracker/models/dose_time_details.dart';
import 'package:medicationtracker/models/medication.dart';
import 'package:medicationtracker/models/medication_regime.dart';
import 'package:medicationtracker/models/user.dart';
import 'package:medicationtracker/assets/icons/icons.dart';

/// Unit test for [MedicationRegime] model.
void main() {

  Medication medication = new Medication('creon10000', 'Pills');
  MedicationRegime medicationRegime = new MedicationRegime(medication: medication, dosage: '10000', dosageUnits: 'units');
  group("Test setting values", (){
    test("Test constructor", () {
      expect(medicationRegime.getMedication(), equals(medication));
      expect(medicationRegime.getDosage(), equals('10000'));
      expect(medicationRegime.getDosageUnits(), equals('units'));
    });
    test("Test setters", (){
      Medication medication2 = new Medication('Salbutamol', 'Inhaled');
      medicationRegime.setMedication(medication2);
      medicationRegime.setDosage('100');
      medicationRegime.setDosageUnits('mcg');
      expect(medicationRegime.getMedication(), equals(medication2));
      expect(medicationRegime.getDosage(), equals('100'));
      expect(medicationRegime.getDosageUnits(), equals('mcg'));
    });
  });

  group("Dose time list manipulation", (){
    TimeOfDay time1 = new TimeOfDay(hour: 12, minute: 0);
    DoseTimeDetail doseTimeDetail1 = new DoseTimeDetail(time: time1);
    TimeOfDay time2 = new TimeOfDay(hour: 16, minute: 30);
    DoseTimeDetail doseTimeDetail2 = new DoseTimeDetail(time: time2);
    medicationRegime.addDoseTime(doseTimeDetail1);
    medicationRegime.addDoseTime((doseTimeDetail2));
    test("Test adding dose times", () {
      expect(medicationRegime.getDosageTimings().length, equals(2));
      expect(medicationRegime.getDosageTimings()[0].getDoseTime(), TimeOfDay(hour: 12, minute: 0));
      expect(medicationRegime.getDosageTimings()[1].getDoseTime(), TimeOfDay(hour: 16, minute: 30));

    });
    test("Test adding duplicate times", () {
      medicationRegime.addDoseTime((doseTimeDetail2));
      expect(medicationRegime.getDosageTimings().length, equals(2));
    });
    test("Test removing dose time", () {
      medicationRegime.removeDoseTime(doseTimeDetail1);
      expect(medicationRegime.getDosageTimings().length, equals(1));
      expect(medicationRegime.getDosageTimings()[0].getDoseTime(), TimeOfDay(hour: 16, minute: 30));
    });
  });
}