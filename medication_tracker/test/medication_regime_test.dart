import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:medicationtracker/models/medication.dart';
import 'package:medicationtracker/models/medication_regime.dart';
import 'package:medicationtracker/models/user.dart';
import 'package:medicationtracker/assets/icons/icons.dart';

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
}