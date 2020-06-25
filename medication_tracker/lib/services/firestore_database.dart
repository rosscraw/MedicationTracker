import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreDatabase {

  final String uid;
  FirestoreDatabase({this.uid});

  // collection reference
  final CollectionReference medicationTrackerUserCollection = Firestore.instance.collection('tracker_users');

  Future updateUserData(String name, List medications) async {
    return await medicationTrackerUserCollection.document(uid).setData({
      'name': name,
      'medications': medications
    });
  }

  // get user data stream
  Stream<QuerySnapshot> get trackerUsers {
    return medicationTrackerUserCollection.snapshots();
  }

}