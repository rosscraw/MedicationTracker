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
    // TODO remove dummy test data
//    if(user != null) {
//      User newUser = User(uid: user.uid);
//      Medication creon = new Medication('Creon',  'Pills');
//      Medication tresiba = new Medication('Tresiba',  'Injection');
//      Medication fiasp = new Medication('Fiasp', 'Injection');
//      Medication salbutamol = new Medication('Salbutamol', 'Inhaled');
//      Medication omeprazole = new Medication('Omeprazole', 'Tablets');
//
//      TimeOfDay timeOfDay = new TimeOfDay(hour: 14, minute: 30);
//      TimeOfDay dose1 = new TimeOfDay(hour: 00, minute: 30);
//      TimeOfDay dose2 = new TimeOfDay(hour: 10, minute: 30);
//      TimeOfDay dose3 = new TimeOfDay(hour: 13, minute: 30);
//      DoseTimeDetails time1 = new DoseTimeDetails(dose1);
//      DoseTimeDetails time2 = new DoseTimeDetails(dose2);
//      DoseTimeDetails time3 = new DoseTimeDetails(dose3);
//      DoseTimeDetails time4 = new DoseTimeDetails(dose2);
//      DoseTimeDetails time5 = new DoseTimeDetails(dose3);
//      DoseTimeDetails time6 = new DoseTimeDetails(dose3);
//
//
//      MedicationRegime creonR = new MedicationRegime(medication: creon, dosage:'150', dosageUnits: 'mg');
//      MedicationRegime tresibaR = new MedicationRegime(medication: tresiba, dosage: '100', dosageUnits: 'units');
//      MedicationRegime fiaspR = new MedicationRegime(medication: fiasp, dosage: '100', dosageUnits: 'units');
//      MedicationRegime salbutamolR = new MedicationRegime(medication: salbutamol, dosage: '100', dosageUnits: 'mcg');
//      MedicationRegime omeprazoleR = new MedicationRegime(medication: omeprazole, dosage: '20', dosageUnits: 'mg');
//
//        newUser.addMedication(creonR);
//        newUser.addMedication(tresibaR);
//      newUser.addMedication(fiaspR);
//        newUser.addMedication(salbutamolR);
//      newUser.addMedication(omeprazoleR);
//        fiaspR.addDoseTime(time1);
//        fiaspR.addDoseTime(time2);
//        fiaspR.addDoseTime(time3);
//        creonR.addDoseTime(time4);
//        creonR.addDoseTime(time5);
//        salbutamolR.addDoseTime(time6);
//        return newUser;
//
//    }
//    else {
//      return null;
//    }
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