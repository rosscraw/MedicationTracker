import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medicationtracker/models/dose_time_details.dart';
import 'package:medicationtracker/models/medication.dart';
import 'package:medicationtracker/models/medication_regime.dart';
import 'package:medicationtracker/models/user.dart';
import 'package:medicationtracker/services/firestore_database.dart';

/// Sign in, register account and sign out methods.
/// Using Firebase's authentication to validate users.
class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Create user object based on FirebaseUser.
  User _userFromFirebase(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }


  /// Auth change user stream.
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebase);
  }


  /// Sign in user with email and password.
  Future signInAccount(String email, String password) async {

    try {
      AuthResult authResult = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = authResult.user;
      return _userFromFirebase(user);
    }
    catch(error) {
        String errorMessage = error.toString();
        print(errorMessage);
        return errorMessage;
    }
  }



  /// Register user with email and password.
  Future registerAccount(String email, String password) async {
    try {
      AuthResult authResult = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = authResult.user;

      //Create new Firestore doc
      await FirestoreDatabase(uid: user.uid).updateUserData(email);
      return _userFromFirebase(user);
    }
    catch(error) {
      print(error.toString());
      return null;
    }
  }



  /// Sign user out of application.
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