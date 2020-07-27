import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medicationtracker/models/medication.dart';
import 'package:medicationtracker/models/medication_regime.dart';
import 'package:medicationtracker/models/user.dart';
import 'package:flutter/material.dart';

class MedicationListController{
  List<MedicationRegime> medicationList = [];

  /// Determines the initial state of the checkbox when screen is loaded.
  bool checkboxInitialState(int index, User user) {
    List<MedicationRegime> medicationList = user.getMedicationList();
    return medicationList[index].getAllMedsTaken();
  }

  /// Sets all medications within a regime to be taken.
  void setMedicationTaken(MedicationRegime medication) {
    medication.setAllMedsTaken(!medication.getAllMedsTaken());
  }

  Future<List<MedicationRegime>> fetchMedications(User user,  AsyncSnapshot medicationIds) async {
    List medicationListIds = medicationIds.data['medication'];
//    int i = 0;

    for(int i = 0; i < medicationListIds.length; i++) {
      DocumentReference medicationIdRef =
      Firestore.instance.collection('medications').document(medicationListIds[i]);
      DocumentSnapshot medicationIdSnapshot = await medicationIdRef.get();

      String a = await medicationIdSnapshot.data['name'];

      Medication medication = new Medication(
          medicationIdSnapshot.data['name'],
          medicationIdSnapshot.data['type']);
      MedicationRegime medicationRegime = new MedicationRegime(
          medicationID: [i].toString(),
          medication: medication,
          dosage: medicationIdSnapshot.data['dosage'],
          dosageUnits: medicationIdSnapshot.data['units']);
      medicationRegime
          .setAllMedsTaken(medicationIdSnapshot.data['all taken']);
      user.addMedication(medicationRegime);
      addMedication(medicationRegime);
    }

//    medicationListIds.forEach((element) async{
//      DocumentReference medicationIdRef =
//      Firestore.instance.collection('medications').document(element);
//      DocumentSnapshot medicationIdSnapshot = await medicationIdRef.get();
//
//      String a = await medicationIdSnapshot.data['name'];
//
//      Medication medication = new Medication(
//          medicationIdSnapshot.data['name'],
//          medicationIdSnapshot.data['type']);
//      MedicationRegime medicationRegime = new MedicationRegime(
//          medicationID: element.toString(),
//          medication: medication,
//          dosage: medicationIdSnapshot.data['dosage'],
//          dosageUnits: medicationIdSnapshot.data['units']);
//      medicationRegime
//          .setAllMedsTaken(medicationIdSnapshot.data['all taken']);
//      user.addMedication(medicationRegime);
//      addMedication(medicationRegime);
//
//    });
    return medicationList;

  }

  void addMedication(MedicationRegime medicationRegime) {
    medicationList.add(medicationRegime);
  }

}