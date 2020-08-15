import 'package:flutter_test/flutter_test.dart';
import 'package:medicationtracker/models/medication.dart';
import 'package:medicationtracker/models/medication_regime.dart';

import 'package:medicationtracker/models/user.dart';

/// Unit test for [User] model.
void main() {

  User user = new User(uid: '1234', name: 'Ross');
    group("Test setting values", (){
      test("Test constructor", () {
        expect(user.getUid(), equals('1234'));
        expect(user.getName(), equals('Ross'));
      });
      test("Test setters", () {
        user.setName('Not Ross');
        expect(user.getName(), equals('Not Ross'));
      });
    });

  group("Test adding and removing from medications list", () {
    Medication medication1 = new Medication('medication1', 'injection');
    Medication medication2 = new Medication('medication2', 'pills');
    MedicationRegime medicationRegime1 = new MedicationRegime(medication: medication1);
    MedicationRegime medicationRegime2 = new MedicationRegime(medication: medication2);
    user.addMedication(medicationRegime1);
    user.addMedication(medicationRegime2);
    test("Test that both medication regimes have been added to user's list", () {
      expect(user.getMedicationList().length, equals(2));
    });
    test("Test that each medication regime is in the correct position in the list", () {
      expect(user.getMedicationList()[0], equals(medicationRegime1));
      expect(user.getMedicationList()[1], equals(medicationRegime2));
    });
    test("Test that a medication is remove from list", (){
      expect(user.removeMedication(medicationRegime1), equals('Medication Removed'));
      expect(user.getMedicationList().contains(medicationRegime1), equals(false));
      expect(user.getMedicationList().contains(medicationRegime2), equals(true));
    });
  });


}