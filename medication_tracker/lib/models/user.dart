import 'package:flutter/material.dart';
import 'package:medicationtracker/models/medication.dart';

import 'dose_time_details.dart';
import 'medication_regime.dart';


/// Represents a User of the application.
class User {

  final String uid;
  String _name;
  List<MedicationRegime> _medications;

  User({this.uid, String name}) {
    setName(name);
    _medications = [];
  }

  /// Get the [User]'s name.
  String getName() {
    return _name;
  }

  /// Set the [User]'s name.
  void setName(String name) {
    _name = name;
  }

  /// Get the [User]'s ID.
  String getUid() {
    return uid;
  }


  /// Get the [User]'s medication list.
  List<MedicationRegime> getMedicationList() {
    return _medications;
  }

  /// Set the [User]'s medication list.
  void setMedicationList(List<MedicationRegime> medicationList) {
    _medications = medicationList;
  }

  /// Add a [MedicationRegime] to the [User]'s medication list.
  void addMedication(MedicationRegime medication) {
    if(_medications.contains(medication)) {
      String error = 'Medication already added to list and cannot be re-dded';
    }
    else {
      _medications.add(medication);
    }
  }

  /// Remove a [MedicationRegime] from the [User]'s medication list.
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