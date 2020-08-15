import 'package:flutter_test/flutter_test.dart';
import 'package:medicationtracker/services/firebase_authentication.dart';
import 'package:medicationtracker/services/firestore_database.dart';
import 'package:mockito/mockito.dart';
import 'package:medicationtracker/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthenticationMock extends Mock implements FirebaseAuthentication{

  @override
  Future signInAccount(String email, String password) {

  }

  @override
  Future registerAccount(String email, String password) {
    // TODO: implement registerAccount
    throw UnimplementedError();
  }

  @override
  Future signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }

  @override
  // TODO: implement user
  Stream<User> get user => throw UnimplementedError();

  @override
  User userFromFirebase(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }
}

class FirestoreDatabaseMock extends Mock implements FirestoreDatabase{
  @override
  Future getMedicationList() {
    // TODO: implement getMedicationList
    throw UnimplementedError();
  }
}