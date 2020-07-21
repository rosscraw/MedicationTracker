import 'package:flutter/material.dart';
import 'package:medicationtracker/models/dose_time_details.dart';
import 'package:medicationtracker/models/medication_regime.dart';
import 'package:medicationtracker/models/user.dart';

class HomeController {
  /// Return list of medications that are due within two hours of now.
  List<DoseTimeDetails> getDueMedications(User user) {
    List<DoseTimeDetails> _dueMedications = [];
    TimeOfDay _timeNow = TimeOfDay.now();
    // TODO add functionality so if marked as taken item is removed from list
    // TODO if no items due display alternative message.
    for (MedicationRegime medication in user.getMedicationList()) {
      for (DoseTimeDetails time in medication.dosageTimings) {
        if (!time.getHasMedBeenTaken() && (time.getDoseTime().hour >= _timeNow.hour
             || (time.getDoseTime().hour == _timeNow.hour && time.getDoseTime().minute >= _timeNow.minute)) &&
            (time.getDoseTime().hour <= _timeNow.hour + 2 && time.getDoseTime().minute <= _timeNow.minute)) {
          _dueMedications.add(time);
        }
      }
    }
    _dueMedications
        .sort((a, b) => a.getDoseTime().hour.compareTo(b.getDoseTime().hour));
    return _dueMedications;
  }

  /// Return list of medications that are overdue.
  List<DoseTimeDetails> getOverdueMedications(User user) {
    List<DoseTimeDetails> _overdueMedications = [];
    TimeOfDay _timeNow = TimeOfDay.now();
    // TODO add functionality so if marked as taken item is removed from list
    // TODO if no items due display alternative message.
    for (MedicationRegime medication in user.getMedicationList()) {
      for (DoseTimeDetails time in medication.dosageTimings) {
        if (!time.getHasMedBeenTaken() && time.getDoseTime().hour < _timeNow.hour || (time.getDoseTime().hour == _timeNow.hour && time.getDoseTime().minute < _timeNow.minute)) {
          _overdueMedications.add(time);
        }
      }
    }
    _overdueMedications
        .sort((a, b) => a.getDoseTime().hour.compareTo(b.getDoseTime().hour));
    return _overdueMedications;
  }


}