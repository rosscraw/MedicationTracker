import 'package:firebase_auth/firebase_auth.dart';
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
  // TODO link real user
  static final user = new DummyUser();
  static final user2 = FirebaseUser;// Dummy Data

  HomeScreen({Key key, this.title, this.color, DummyUser user}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var dummyList = HomeScreen.user.getDummyUser().getMedicationList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 500.0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                overdueList(),
                dueList(),
              ],
            ),
          ),
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
        if (time.getDoseTime().hour >= timeNow.hour &&
            time.getDoseTime().hour <= timeNow.hour &&
            !time.getHasMedBeenTaken()) {
          dueMedications.add(time);
        }
      }
    }
    dueMedications
        .sort((a, b) => a.getDoseTime().hour.compareTo(b.getDoseTime().hour));
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
    overdueMedications
        .sort((a, b) => a.getDoseTime().hour.compareTo(b.getDoseTime().hour));
    return overdueMedications;
  }

  /// Shows list if there are any overdue medications.
  /// Shows text informing user none are overdue if there are no overdue meds.
  Widget overdueList() {
    if (getOverdueMedications().isEmpty) {
      return Text(
        'No medications are overdue!',
        style: TextStyle(
          fontSize: 20,
        ),
      );
    } else {
      return Column(
        children: [
          Text(
            'Overdue Medications',
            style: TextStyle(
              fontSize: 30.0,
              color: Colors.blue,
            ),
          ),
          MedicationTimesList(getOverdueMedications()),
        ],
      );
    }
  }

  /// Shows list if there are any medications due soon.
  /// Shows text informing user none are due if there are none due soon.
  Widget dueList() {
    if (getDueMedications().isEmpty) {
      return Text(
        'No medications are due soon!',
        style: TextStyle(
          fontSize: 20,
        ),
      );
    } else {
      return Column(
        children: [
          Text(
            "Medications Due Soon",
            style: TextStyle(
              fontSize: 30.0,
              color: Colors.blue,
            ),
          ), //
          MedicationTimesList(getDueMedications()),
        ],
      );
    }
  }


}
