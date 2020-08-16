import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medicationtracker/models/dose_time_details.dart';
import 'package:medicationtracker/models/medication.dart';
import 'package:medicationtracker/models/medication_regime.dart';
import 'package:medicationtracker/models/user.dart';
import 'package:medicationtracker/services/firestore_database.dart';

/// Class to handle sign in, register account and sign out methods.
/// Using Firebase's authentication to validate users.
class FirebaseAuthentication {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Create [User] object based on FirebaseUser.
  User userFromFirebase(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  /// Authentication change [User] stream, used to access [User] throughout application.
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(userFromFirebase);
  }

  /// Sign in [User] with email and password.
  Future signInAccount(String email, String password) async {

    try {
      AuthResult authResult = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = authResult.user;

      return userFromFirebase(user);
    }
    catch(error) {
        return error.toString();
    }
  }

  /// Register [User] with email and password.
  Future registerAccount(String email, String password) async {
    try {
      AuthResult authResult = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser firebaseUser = authResult.user;
      User user = userFromFirebase(firebaseUser);
      //Create new Firestore doc
      await FirestoreDatabase(user: user).updateUserData(email);
      return user;
    }
    catch(error) {
      print(error.toString());
      return null;
    }
  }

  /// Sign [User] out of application.
  Future signOut() async {
    try {
      return await _auth.signOut();
    }
    catch(error) {
      print(error.toString());
      return null;
    }
  }
}