import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicationtracker/models/dose_time_details.dart';
import 'package:medicationtracker/models/medication.dart';
import 'package:medicationtracker/models/medication_regime.dart';
import 'package:medicationtracker/models/user.dart';

class FirestoreDatabase {
  //final String uid;
  final User user;
  FirestoreDatabase({this.user});

  // collection reference
  final CollectionReference usersCollection =
      Firestore.instance.collection('users');
  final CollectionReference medicationsCollection =
      Firestore.instance.collection('medications');
  final CollectionReference doseTimesCollection =
      Firestore.instance.collection('times');

  /// Updates the user's data, saves their email address to their user document.
  Future updateUserData(String name) async {
    print('Success');
    return await usersCollection
        .document(user.getUid())
        .setData({'name': name, 'medication': []});
  }

  /// Add a medication to the medications Firestore Document.
  Future<void> addMedication(MedicationRegime medication) async {
    usersCollection.document(user.getUid()).setData({
      'medication': FieldValue.arrayUnion([medication.getMedicationID()])
    }, merge: true);
    return await medicationsCollection
        .document(medication.getMedicationID())
        .setData({
          'name': medication.getMedication().getName(),
          'type': medication.getMedication().getMedType(),
          'dosage': medication.getDosage(),
          'units': medication.getDosageUnits(),
          'all taken': medication.getAllMedsTaken(),
          'dose times': []
        })
        .then((value) => print('Medication Added'))
        .catchError((error) => print("Failed to update: $error"));
  }

  /// Update a medication's Firestore Document.
  Future<void> editMedication(MedicationRegime medication) async {
    return await medicationsCollection
        .document(medication.getMedicationID())
        .updateData({
          'name': medication.getMedication().getName(),
          'type': medication.getMedication().getMedType(),
          'dosage': medication.getDosage(),
          'units': medication.getDosageUnits(),
        })
        .then((value) => print('Medication Updated'))
        .catchError((error) => print("Failed to update: $error"));
  }

  /// Delete a medication's Firestore Document.
  Future<void> deleteMedication(MedicationRegime medication) async {
    usersCollection.document(user.getUid()).updateData({
      'medication': FieldValue.arrayRemove([medication.getMedicationID()])
    });
    return await medicationsCollection
        .document(medication.getMedicationID())
        .delete()
        .then((value) => print('Medication Deleted'))
        .catchError((error) => print("Failed to delete: $error"));
  }

  /// Set the all taken status of a medication.
  Future<void> editMedicationTaken(MedicationRegime medication) async {
    return await medicationsCollection
        .document(medication.getMedicationID())
        .updateData({'all taken': medication.getAllMedsTaken()});
  }

  /// Add a dose time to the times Firestore collection.
  Future<void> addMedicationDosages(MedicationRegime medication) async {
    if (medication.getDosageTimings().isNotEmpty) {
      for (DoseTimeDetail time in medication.getDosageTimings()) {
        var timeId = time.getDoseTimeId();
            //time.getDoseTime().toString() + Random().nextInt(4294967296).toString();
        medicationsCollection.document(medication.getMedicationID()).setData({
          'dose times': FieldValue.arrayUnion(([timeId]))
        }, merge: true);
        //TODO time id
        await doseTimesCollection.document(timeId).setData({
          'hour': time.getDoseTime().hour,
          'minute': time.getDoseTime().minute,
          'been taken': time.getHasMedBeenTaken(),
          'medication': time.getMedicationRegime().getMedicationID()
        });
      }
    }
  }

  /// Edit a dose time's details.
  Future<void> editMedicationDosages(DoseTimeDetail time, String medId) async {
    return await doseTimesCollection.document(time.getDoseTimeId()).setData({
      'hour': time.getDoseTime().hour,
      'minute': time.getDoseTime().minute,
      'been taken': time.getHasMedBeenTaken(),
      'medication': medId
    }, merge: true);

  }

  /// Delete a dose time's Firestore Document.
  Future<void> deleteMedicationDosages(DoseTimeDetail time) async{
    medicationsCollection.document(time.getMedicationRegime().getMedicationID()).updateData({
      'dose times' : FieldValue.arrayRemove([time.getDoseTimeId()])
    });
    return await doseTimesCollection.document(time.getDoseTimeId()).delete();
  }

  Future getUserSnapshot() async {
    // Gets Current user's collection
    DocumentReference userIdRef = usersCollection.document(user.getUid());
    DocumentSnapshot userIdSnapshot = await userIdRef.get();
    return userIdSnapshot.data;
  }

  Future getMedicationSnapshot(String medId) async {
    DocumentReference medicationIdRef = medicationsCollection.document(medId);
    DocumentSnapshot medicationIdSnapshot = await medicationIdRef.get();
    return medicationIdSnapshot.data;
  }

  Future getMedicationId(int index) async {
    var userSnapshot = await getUserSnapshot();
    var medicationId = await userSnapshot['medication'][index];
    return medicationId;
  }

  Future getMedicationSnapshotAtIndex(int index) async {
    var userSnapshot = await getUserSnapshot();
    var medicationId = userSnapshot['medication'][index];

    return await getMedicationSnapshot(medicationId);
  }

  Future getTimeSnapshot(String timeId) async {
    DocumentReference timeIdRef = doseTimesCollection.document(timeId);
    DocumentSnapshot timeIdSnapshot = await timeIdRef.get();
    return timeIdSnapshot.data;
  }

  Future getTimeId(MedicationRegime medication, int index) async {
    var medicationSnapshot = await getMedicationSnapshot(medication.getMedicationID());
    var timeId = await medicationSnapshot['dose times'][index];
    return timeId;
  }

  Future getTimeSnapshotAtIndex(MedicationRegime medication, int index) async {
    var medicationSnapshot = await getMedicationSnapshot(medication.getMedicationID());
    var timeId = await medicationSnapshot['dose times'][index];

    return await getTimeSnapshot(timeId);
  }


  /// Gets a User's medication list data from Firestore
  Future getMedicationList() async {
    var userIdSnapshot = await getUserSnapshot();
    List<MedicationRegime> medicationList = [];
    for (int i = 0; i < userIdSnapshot['medication'].length; i++) {
      var medicationSnapshot = await getMedicationSnapshotAtIndex(i);
      String medicationId = await getMedicationId(i);
      String name = medicationSnapshot['name'];
      String dosage = medicationSnapshot['dosage'];
      String units = medicationSnapshot['units'];
      String type = medicationSnapshot['type'];

      Medication medication = new Medication(name, type);

      MedicationRegime medicationRegime = new MedicationRegime(
          medicationID: medicationId,
          medication: medication,
          dosage: dosage,
          dosageUnits: units);
      medicationRegime.setAllMedsTaken(medicationSnapshot['all taken']);

      for (int i = 0; i < medicationSnapshot['dose times'].length; i++) {
        var timeSnapshot = await getTimeSnapshotAtIndex(medicationRegime, i);
        int hour = timeSnapshot['hour'];
        int minute = timeSnapshot['minute'];
        bool beenTaken = timeSnapshot['been taken'];
        TimeOfDay timeOfDay = TimeOfDay(hour: hour, minute: minute);
        DoseTimeDetail time = new DoseTimeDetail(time: timeOfDay);
        time.setHasMedBeenTaken(beenTaken);
        time.setMedicationRegime(medicationRegime);

        medicationRegime.addDoseTime(time);

      }

//      //TODO add times
//      medicationRegime.addDoseTime(new DoseTimeDetails(time: TimeOfDay.now()));

      medicationList.add(medicationRegime);
    }

    user.setMedicationList(medicationList);
    user.getMedicationList().sort((a, b) => a
        .getMedication()
        .getName()
        .toUpperCase()
        .compareTo(b.getMedication().getName().toUpperCase()));
    return medicationList;
  }

  // get user data stream
  Stream<QuerySnapshot> get trackerUsers {
    return usersCollection.snapshots();
  }
//  }

}
