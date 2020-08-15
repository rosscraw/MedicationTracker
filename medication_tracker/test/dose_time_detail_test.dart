import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medicationtracker/models/dose_time_details.dart';

/// Unit test for [DoseTimeDetail] model.
void main() {
  TimeOfDay time = new TimeOfDay(hour: 12, minute: 0);
  DoseTimeDetail doseTimeDetail = new DoseTimeDetail(time: time);

  test("Test constructor", () {
    expect(doseTimeDetail.getDoseTime().hour, equals(12));
    expect(doseTimeDetail.getDoseTime().minute, equals(0));
    expect(doseTimeDetail.getHasMedBeenTaken(), equals(false));
    expect(doseTimeDetail.getDoseTimeId(), equals(null));
  });

  test("Test Setters", () {
    TimeOfDay newTime = new TimeOfDay(hour: 16, minute: 33);
    doseTimeDetail.setDoseTime(newTime);
    doseTimeDetail.setHasMedBeenTaken(true);
    doseTimeDetail.setDoseTimeId('1234');
    expect(doseTimeDetail.getDoseTime().hour, equals(16));
    expect(doseTimeDetail.getDoseTime().minute, equals(33));
    expect(doseTimeDetail.getHasMedBeenTaken(), equals(true));
    expect(doseTimeDetail.getDoseTimeId(), equals('1234'));

  });
}