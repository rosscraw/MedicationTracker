import 'package:flutter_test/flutter_test.dart';
import 'package:medicationtracker/models/medication.dart';
import 'package:medicationtracker/assets/icons/icons.dart';

/// Unit test for [Medication] model
void main() {

  Medication medication = new Medication('creon10000', 'Pills');

  group("Test setting values", (){
    test("Test constructor", () {
      expect(medication.getName(), equals('creon10000'));
      expect(medication.getMedType(), equals('Pills'));
    });
    test("Test icon data", () {
      expect(medication.getMedicationIcon(), equals(DownloadedIcons.pills));
    });
    test("Test setters", (){
      medication.setName('Salbutamol');
      medication.setMedType('Inhaled');
      expect(medication.getName(), equals('Salbutamol'));
      expect(medication.getMedType(), equals('Inhaled'));
      expect(medication.getMedicationIcon(), equals(DownloadedIcons.wind));
    });
  });
}