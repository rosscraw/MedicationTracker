import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medicationtracker/models/dose_time_details.dart';
import 'package:medicationtracker/models/medication_regime.dart';

class FirestoreDatabase {

  final String uid;
  FirestoreDatabase({this.uid});

  // collection reference
  final CollectionReference medicationTrackerUserCollection = Firestore.instance.collection('users');
  final CollectionReference medicationTrackerMedicationCollection = Firestore.instance.collection('medications');
  final CollectionReference medicationTrackerDoseTimeCollection = Firestore.instance.collection('times');

  /// Updates the user's data, saves their email address to their user document.
  Future updateUserData(String name) async {
    print('Success');
    return await medicationTrackerUserCollection.document(uid).setData({
      'name': name,
      'medication' : []
    });
    }

    /// Add a medication to the medications Firestore Document.
    Future<void> addMedication(MedicationRegime medication) async {
      medicationTrackerUserCollection.document(uid).setData({
        'medication' : FieldValue.arrayUnion([medication.getMedicationID()])
      }, merge: true);
    return await medicationTrackerMedicationCollection.document(medication.getMedicationID()).setData({
      'name' : medication.getMedication().getName(),
      'type': medication.getMedication().getMedType(),
      'dosage' : medication.getDosage(),
      'units': medication.getDosageUnits(),

    }).then((value) => print('Medication Added')).catchError((error) => print("Failed to update: $error"));

    }

    /// Update a medication's Firestore Document.
    Future<void> editMedication(MedicationRegime medication) async {
    return await medicationTrackerMedicationCollection.document(medication.getMedicationID()).updateData({
      'name' : medication.getMedication().getName(),
      'type': medication.getMedication().getMedType(),
      'dosage' : medication.getDosage(),
      'units': medication.getDosageUnits(),
    }).then((value) => print('Medication Updated')).catchError((error) => print("Failed to update: $error"));

    }

    /// Delete a medication's Firestore Document.
    Future<void> deleteMedication(MedicationRegime medication) async {
      medicationTrackerUserCollection.document(uid).updateData({
        'medication' : FieldValue.arrayRemove([medication.getMedicationID()])
      });
    return await medicationTrackerMedicationCollection.document(medication.getMedicationID()).delete().
          then((value) => print('Medication Deleted')).catchError((error) => print("Failed to delete: $error"));
    }

    /// Add a dose time to the times Firestore collection.
    Future<void> addMedicationDosages(MedicationRegime medication) async {
    if(medication.getDosageTimings().isNotEmpty) {
      for(DoseTimeDetails time in medication.getDosageTimings()) {
        return await medicationTrackerDoseTimeCollection.add({
          'time' : time.getDoseTime().toString()
        });
      }

    }

    return null;
    }




  // get user data stream
  Stream<QuerySnapshot> get trackerUsers {
    return medicationTrackerUserCollection.snapshots();
  }

  Stream<QuerySnapshot> get medicationRegimes {
    return medicationTrackerMedicationCollection.snapshots();
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