

import 'package:medicationtracker/back_end/medication.dart';
import 'package:medicationtracker/back_end/user.dart';

class DummyUser {

  User dummyUser = new User(uid: 'user1234', name: 'Ross');
  Medication creon = new Medication('Creon', '150mg', 'Capsule');
  Medication tresiba = new Medication("Tresiba", "100 units", "Injection");
  Medication fiasp = new Medication("Fiasp", "100 units", "Injection");
  Medication salbutamol = new Medication("Salbutamol", "100mcg", "Inhaler");
  Medication omeprazole = new Medication("Omeprazole", "20mg", "Capsule");

  DummyUser() {
    dummyUser.addMedication(creon);
    dummyUser.addMedication(tresiba);
    dummyUser.addMedication(fiasp);
    dummyUser.addMedication(salbutamol);
    dummyUser.addMedication(omeprazole);
  }



  User getDummyUser() {
    return dummyUser;
  }


}