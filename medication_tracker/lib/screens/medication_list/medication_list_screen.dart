import 'package:flutter/material.dart';
import 'package:medicationtracker/back_end/medication.dart';
import 'package:medicationtracker/back_end/medication_regime.dart';
import 'package:medicationtracker/dummy_data/dummy_user.dart';
import 'add_medication_screen.dart';
import 'medication_details_screen.dart';
import 'package:medicationtracker/services/firestore_database.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// Screen that displays a list of medications in the user's medication list.
/// User can check a checkbox to confirm whether or not they have taken the medication.
class MedicationScreen extends StatefulWidget {
  MedicationScreen({Key key, this.title}) : super(key: key);

  final String title;


  @override
  _MedicationScreenState createState() => _MedicationScreenState();
}

class _MedicationScreenState extends State<MedicationScreen> {
  static final dummyUser = new DummyUser(); // Dummy Data
  var dummyList = dummyUser.getDummyUser().getMedicationList(); // Dummy Data

  @override
  Widget build(BuildContext context) {
    return StreamProvider<QuerySnapshot>.value(
      value: FirestoreDatabase().trackerUsers,
      child: Scaffold(
        body: Center(
          child: SizedBox(
            width: 500.0,
            child: Container(
                child: ListView.builder(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 50),
                  itemCount: dummyList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                          leading: Icon(
                              dummyList[index].getMedication().getMedicationIcon()
                          ),
                          //TODO link to database
                          title: Text(dummyList[index].getMedication().getName()),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Checkbox(
                                value: dummyList[index].getMedication().getHasMedBeenTaken(),
                                onChanged: (bool newValue) {
                                  setState(() {
                                    dummyList[index].getMedication().setHasMedBeenTaken(!dummyList[index].getMedication().getHasMedBeenTaken());
                                  });
                                },
                              ),
                              FlatButton.icon(
                                icon: Icon(
                                    Icons.info_outline,
                                ),
                                label: Text(
                                  'info'
                                ),
                                onPressed: () {
                                  navigateToMedicationDetails(dummyList[index]);
                                  },
                              ),
                            ],
                          ),
                      ),
                    );
                  },
                ),
            ),
          ),
        ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              navigateToAddMedication();
            },
            label: Text('Add Medication'),
            tooltip: 'Add Medication',
            icon: Icon(Icons.add),
          ),
      ),
    );
  }

  /// Pushes Add Medication Screen to top of the stack to display to user.
  void navigateToAddMedication() {
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => AddMedicationScreen(dummyUser.getDummyUser()))
    ).then((value) {
      setState(() {
      });
    });
  }

  /// Pushes Medication Details Screen for Medication at [index] to display to user.
  void navigateToMedicationDetails(MedicationRegime medication) {
    // TODO Firestore Integration
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => MedicationDetails(medication, dummyUser.getDummyUser()))
    ).then((value) {
      setState(() {
      });
    });
  }


}
