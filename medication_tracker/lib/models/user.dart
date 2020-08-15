import 'package:flutter/material.dart';
import 'package:medicationtracker/models/medication.dart';

import 'dose_time_details.dart';
import 'medication_regime.dart';


/// Represents a User of the application.
class User {

  final String uid;
  String _email;
  String _name;
  List<MedicationRegime> _medications;

  User({this.uid, String name}) {
    setName(name);
    _medications = [];
  }

  String getName() {
    return _name;
  }

  void setName(String name) {
    _name = name;
  }

  String getUid() {
    return uid;
  }


  List<MedicationRegime> getMedicationList() {
    return _medications;
  }

  void setMedicationList(List<MedicationRegime> medicationList) {
    _medications = medicationList;
  }

  void addMedication(MedicationRegime medication) {
    if(_medications.contains(medication)) {
      String error = 'Medication already added to list and cannot be re-dded';
    }
    else {
      _medications.add(medication);
    }
  }

  String removeMedication(MedicationRegime medication) {
    if(_medications.contains(medication)) {
      _medications.remove(medication);
      return 'Medication Removed';
      }
    else {
      return 'Medication is not currently in list and cannot be removed';
    }
  }

  /// Return list of [DoseTimeDetail]s that are overdue.
  List<DoseTimeDetail> getOverdueMedications() {
    List<DoseTimeDetail> _overdueMedications = [];
    TimeOfDay _timeNow = TimeOfDay.now();
    for (MedicationRegime medication in _medications) {
      for (DoseTimeDetail time in medication.dosageTimings) {
        double doseTime = time.getDoseTime().hour + time.getDoseTime().minute/60;
        double now = _timeNow.hour + _timeNow.minute/60;
        if (!time.getHasMedBeenTaken() && doseTime < now) {
          _overdueMedications.add(time);
        }
      }
    }
    _overdueMedications
        .sort((a, b) => a.getDoseTime().hour.compareTo(b.getDoseTime().hour));
    return _overdueMedications;
  }

  /// Return list of [DoseTimeDetail]s that are due within two hours of now.
  List<DoseTimeDetail> getDueMedications() {
    List<DoseTimeDetail> _dueMedications = [];
    TimeOfDay _timeNow = TimeOfDay.now();
    for (MedicationRegime medication in _medications) {
      for (DoseTimeDetail time in medication.dosageTimings) {
        double doseTime = time.getDoseTime().hour + time.getDoseTime().minute/60;
        double now = _timeNow.hour + _timeNow.minute/60;
        print(now.toString());
        if (!time.getHasMedBeenTaken() && doseTime >= now && doseTime <= now + 2) {
          _dueMedications.add(time);
        }
      }
    }
    _dueMedications
        .sort((a, b) => a.getDoseTime().hour.compareTo(b.getDoseTime().hour));
    return _dueMedications;
  }
}