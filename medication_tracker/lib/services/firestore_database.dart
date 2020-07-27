import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:medicationtracker/models/dose_time_details.dart';
import 'package:medicationtracker/models/medication.dart';
import 'package:medicationtracker/models/medication_regime.dart';
import 'package:medicationtracker/models/user.dart';

class FirestoreDatabase {

  final String uid;
  FirestoreDatabase({this.uid});

  // collection reference
  final CollectionReference usersCollection = Firestore.instance.collection('users');
  final CollectionReference medicationsCollection = Firestore.instance.collection('medications');
  final CollectionReference doseTimesCollection = Firestore.instance.collection('times');

  /// Updates the user's data, saves their email address to their user document.
  Future updateUserData(String name) async {
    print('Success');
    return await usersCollection.document(uid).setData({
      'name': name,
      'medication' : []
    });
    }

    /// Add a medication to the medications Firestore Document.
    Future<void> addMedication(MedicationRegime medication) async {
      usersCollection.document(uid).setData({
        'medication' : FieldValue.arrayUnion([medication.getMedicationID()])
      }, merge: true);
    return await medicationsCollection.document(medication.getMedicationID()).setData({
      'name' : medication.getMedication().getName(),
      'type': medication.getMedication().getMedType(),
      'dosage' : medication.getDosage(),
      'units': medication.getDosageUnits(),
      'all taken' : medication.getAllMedsTaken()
    }).then((value) => print('Medication Added')).catchError((error) => print("Failed to update: $error"));
    }

    /// Update a medication's Firestore Document.
    Future<void> editMedication(MedicationRegime medication) async {
    return await medicationsCollection.document(medication.getMedicationID()).updateData({
      'name' : medication.getMedication().getName(),
      'type': medication.getMedication().getMedType(),
      'dosage' : medication.getDosage(),
      'units': medication.getDosageUnits(),
    }).then((value) => print('Medication Updated')).catchError((error) => print("Failed to update: $error"));
    }

    /// Delete a medication's Firestore Document.
    Future<void> deleteMedication(MedicationRegime medication) async {
      usersCollection.document(uid).updateData({
        'medication' : FieldValue.arrayRemove([medication.getMedicationID()])
      });
    return await medicationsCollection.document(medication.getMedicationID()).delete().
          then((value) => print('Medication Deleted')).catchError((error) => print("Failed to delete: $error"));
    }

    /// Set the all taken status of a medication.
    Future<void> editMedicationTaken(MedicationRegime medication) async {
    return await medicationsCollection.document(medication.getMedicationID()).updateData({
      'all taken' : medication.getAllMedsTaken()
    });
    }

    /// Add a dose time to the times Firestore collection.
    Future<void> addMedicationDosages(MedicationRegime medication) async {
    if(medication.getDosageTimings().isNotEmpty) {
      for(DoseTimeDetails time in medication.getDosageTimings()) {
        return await doseTimesCollection.add({
          'time' : time.getDoseTime().toString()
        });
      }

    }

    return null;
    }

    List<MedicationRegime> _medicationListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return _medicationRegimeFromSnapshot(doc);
    });
    }

    MedicationRegime _medicationRegimeFromSnapshot(DocumentSnapshot snapshot) {
    return MedicationRegime(
      medication: new Medication(snapshot.data['name'], snapshot.data['type']),
      medicationID: snapshot.documentID,
      dosage: snapshot.data['dosage'],
      dosageUnits: snapshot.data['units']
    );
    }

  Future getMedicationList(User user) async{


    // Gets Current user's collection

    DocumentReference userIdRef = usersCollection.document(user.getUid());

    DocumentSnapshot userIdSnapshot = await userIdRef.get();

    return userIdSnapshot.data;


    /// List of a user's medication references
    List data = userIdSnapshot.data['medication'].to;


    List<MedicationRegime> medicationList = [];

     data.forEach((element) async{
      DocumentReference medicationIdRef = medicationsCollection.document(element);
      DocumentSnapshot medicationIdSnapshot = await medicationIdRef.get();
      return medicationIdSnapshot.data;

      Medication medication = new Medication(medicationIdSnapshot.data['name'], medicationIdSnapshot.data['type']);
      MedicationRegime medicationRegime = new MedicationRegime(medicationID: element.toString(), medication: medication, dosage: medicationIdSnapshot.data['dosage'], dosageUnits: medicationIdSnapshot.data['units']);
      medicationRegime.setAllMedsTaken(medicationIdSnapshot.data['all taken']);
      print('####################################');
      print(medicationRegime.getMedication().getName());
      user.addMedication(medicationRegime);
      medicationList.add(medicationRegime);
      //meds.add(medicationRegime);
      //return meds;
      print(medicationList.length);
      return medicationList;

    });
    return medicationList;
    //return doc2.data;

  }

  Future getMedicationItem(String medId) async{
    DocumentReference medicationIdRef = medicationsCollection.document(medId);
    DocumentSnapshot medicationIdSnapshot = await medicationIdRef.get();
    return medicationIdSnapshot.data;

//    Medication medication = new Medication(medicationIdSnapshot.data['name'], medicationIdSnapshot.data['type']);
//    MedicationRegime medicationRegime = new MedicationRegime(medicationID: element.toString(), medication: medication, dosage: medicationIdSnapshot.data['dosage'], dosageUnits: medicationIdSnapshot.data['units']);
//    medicationRegime.setAllMedsTaken(medicationIdSnapshot.data['all taken']);
//    print('####################################');
//    print(medicationRegime.getMedication().getName());
//    user.addMedication(medicationRegime);
//    medicationList.add(medicationRegime);

  }

  Future fetchMedications(User user) async{
    DocumentReference userIdRef = usersCollection.document(user.getUid());

    DocumentSnapshot userIdSnapshot = await userIdRef.get();
    return userIdSnapshot.data;
  }






  // get user data stream
  Stream<QuerySnapshot> get trackerUsers {
    return usersCollection.snapshots();
  }

  Stream<QuerySnapshot> get medicationRegimes {
    return medicationsCollection.snapshots();
  }

  Stream<List> streamMedicationList(User user) {
    return getMedicationList(user).asStream();
  }
  
//  Future addMedication(MedicationRegime medication) async{
//    return await medicationTrackerUserCollection.document(uid).updateData({
//      'medications': FieldValue.arrayUnion([{
//        'name' : medication.getMedication().getName(),
//        'dose' : medication.getDosage().toString(),
//        'units' : medication.getDosageUnits(),
//        'times' : '08:00'
//      }])
//    },
//    );
//  }

}