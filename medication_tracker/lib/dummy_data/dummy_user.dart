

import 'package:flutter/material.dart';
import 'package:medicationtracker/back_end/dose_time_details.dart';
import 'package:medicationtracker/back_end/medication.dart';
import 'package:medicationtracker/back_end/medication_regime.dart';
import 'package:medicationtracker/back_end/user.dart';

class DummyUser {

  User dummyUser = new User(uid: 'user1234', name: 'Ross');
  static Medication creon = new Medication('Creon',  'Pills');
  static Medication tresiba = new Medication('Tresiba',  'Injection');
  static Medication fiasp = new Medication('Fiasp', 'Injection');
  static Medication salbutamol = new Medication('Salbutamol', 'Inhaler');
  static Medication omeprazole = new Medication('Omeprazole', 'Tablets');

  static TimeOfDay timeOfDay = new TimeOfDay(hour: 14, minute: 30);
  static TimeOfDay dose1 = new TimeOfDay(hour: 16, minute: 30);
  static TimeOfDay dose2 = new TimeOfDay(hour: 10, minute: 30);
  static TimeOfDay dose3 = new TimeOfDay(hour: 13, minute: 30);
  DoseTimeDetails time1 = new DoseTimeDetails(dose1);
  DoseTimeDetails time2 = new DoseTimeDetails(dose2);
  DoseTimeDetails time3 = new DoseTimeDetails(dose3);
  DoseTimeDetails time4 = new DoseTimeDetails(dose2);
  DoseTimeDetails time5 = new DoseTimeDetails(dose3);
  DoseTimeDetails time6 = new DoseTimeDetails(dose3);


  MedicationRegime creonR = new MedicationRegime(creon, '150mg');
  MedicationRegime tresibaR = new MedicationRegime(tresiba, '100 units');
  MedicationRegime fiaspR = new MedicationRegime(fiasp, '100 units');
  MedicationRegime salbutamolR = new MedicationRegime(salbutamol, '100mcg');
  MedicationRegime omeprazoleR = new MedicationRegime(omeprazole, '20mg');

 

  

  DummyUser() {
    dummyUser.addMedication(creonR);
    dummyUser.addMedication(tresibaR);
    dummyUser.addMedication(fiaspR);
    dummyUser.addMedication(salbutamolR);
    dummyUser.addMedication(omeprazoleR);
    fiaspR.addDoseTime(time1);
    fiaspR.addDoseTime(time2);
    fiaspR.addDoseTime(time3);
    creonR.addDoseTime(time4);
    creonR.addDoseTime(time5);
    salbutamolR.addDoseTime(time6);

  }



  User getDummyUser() {
    return dummyUser;
  }


}