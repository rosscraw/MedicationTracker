import 'package:flutter/material.dart';
import 'package:medicationtracker/back_end/dose_time_details.dart';
import 'package:medicationtracker/back_end/medication.dart';
import 'package:medicationtracker/back_end/medication_regime.dart';
import 'package:medicationtracker/dummy_data/dummy_user.dart';
import 'package:medicationtracker/screens/custom_widgets/medication_times_list.dart';

/// Home screen of the application.
/// First screen visible after log in.
/// Shows user any medications that are due to be taken within the next two hours.
class HomeScreen extends StatefulWidget {
  final Color color;
  final String title;
  static final dummyUser = new DummyUser(); // Dummy Data

  HomeScreen({Key key, this.title, this.color}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var dummyList = HomeScreen.dummyUser.getDummyUser().getMedicationList();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text('Overdue'),
            MedicationTimesList(getOverdueMedications()),
            Text("Due Soon"),//
            MedicationTimesList(getDueMedications()),
          ],
        ),
      ),
    );
  }

  /// Return list of medications that are due within two hours of now.
  List<DoseTimeDetails> getDueMedications() {
    List<DoseTimeDetails> dueMedications = [];
    TimeOfDay timeNow = TimeOfDay.now();
    int index = 0;
    // TODO add functionality so if marked as taken item is removed from list
    // TODO if no items due display alternative message.
    for (MedicationRegime medication in dummyList) {
      for (DoseTimeDetails time in medication.dosageTimings) {
        if (time.getDoseTime().hour >= timeNow.hour && time.getDoseTime().hour <= timeNow.hour  &&
            !time.getHasMedBeenTaken()) {
          dueMedications.add(time);
        }
      }
    }
    return dueMedications;
  }

  /// Return list of medications that are overdue.
  List<DoseTimeDetails> getOverdueMedications() {
    List<DoseTimeDetails> overdueMedications = [];
    TimeOfDay timeNow = TimeOfDay.now();
    // TODO add functionality so if marked as taken item is removed from list
    // TODO if no items due display alternative message.
    for (MedicationRegime medication in dummyList) {
      for (DoseTimeDetails time in medication.dosageTimings) {
        if (time.getDoseTime().hour < timeNow.hour &&
            !time.getHasMedBeenTaken()) {
          overdueMedications.add(time);
        }
      }
    }
    return overdueMedications;
  }
}
