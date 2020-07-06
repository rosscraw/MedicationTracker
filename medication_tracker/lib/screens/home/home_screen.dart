import 'package:flutter/material.dart';
import 'package:medicationtracker/back_end/dose_time_details.dart';
import 'package:medicationtracker/back_end/medication_regime.dart';
import 'package:medicationtracker/dummy_data/dummy_user.dart';

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
        child: Column(
          children: <Widget>[
            Text("Due Soon"),
            SizedBox(
              width: 500.0,
              height: 400.0,
              child: ListView.builder(
                  itemCount: getDueMedications().length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text(getDueMedications()[index].getMedication().getName()),
                      ),
                    );
                  }),
            ),
          ],
        ),
    );
  }

  /// Return list of medications that are due within two hours of now.
  List<MedicationRegime> getDueMedications() {
    List<MedicationRegime> dueMedications = [];
    TimeOfDay timeNow = TimeOfDay.now();
    // TODO add functionality so if marked as taken item is removed from list
    // TODO if no items due display alternative message.
    for (var med in dummyList) {
      for(DoseTimeDetails time in med.dosageTimings ){
        if(time.getDoseTime().hour <= timeNow.hour + 2) {
          dueMedications.add(med);
      }
      }
    }
    return dueMedications;
  }
}


