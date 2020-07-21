import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:medicationtracker/assets/icons/icons.dart';

/// Represents a medication that a User may have in their medication list.
class Medication{

  String _name = '';
  //String _dosage;
  String _medType = '';
  bool _hasMedBeenTaken = false;

  Medication(String name,  String medType) {
    setName(name);
    //setDosage(dosage);
    setMedType(medType);
  }

  String getName() {
    return _name;
  }

  void setName(String name) {
    _name = name;
  }

//  String getDosage() {
//    return _dosage;
//  }

//  void setDosage(String dosage) {
//    _dosage = dosage;
//  }

  String getMedType() {
    return _medType;
  }

  void setMedType(String medType) {
    _medType = medType;
  }

  /// Allocates specific icon depending upon the type of medication.
  IconData getMedicationIcon() {
    if (_medType == 'Pills') {
      return DownloadedIcons.pills;
    }
    else if (_medType == 'Tablets') {
      return DownloadedIcons.tablets;
    }
    else if (_medType == 'Injection') {
      return DownloadedIcons.syringe;
    }
    else if (_medType == 'Inhaled'){
      return DownloadedIcons.wind;
    }
    else {
      return Icons.healing;
    }
  }

}
