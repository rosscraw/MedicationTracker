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
  //TODO use real user
  static final user = new DummyUser(); // Dummy Data
  var medicationList = user.getDummyUser().getMedicationList(); // Dummy Data

  @override
  Widget build(BuildContext context) {
    return StreamProvider<QuerySnapshot>.value(
      value: FirestoreDatabase().trackerUsers,
      child: Scaffold(
        body: Center(
          child: SizedBox(
            width: 500.0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: getMedicationListView(),
            ),
          ),
        ),
        floatingActionButton: addMedicationButton(),
      ),
    );
  }

  /// Add medication floating action button.
  FloatingActionButton addMedicationButton() {
    return FloatingActionButton.extended(
      onPressed: () {
        navigateToAddMedication();
      },
      label: Text('Add Medication'),
      tooltip: 'Add Medication',
      icon: Icon(Icons.add),
    );
  }

  /// Column that contains text and the Listview that displays all user's medications with checkboxes.
  Column getMedicationListView() {
    return Column(
      children: [
        Text(
          'Medications',
          style: TextStyle(
            fontSize: 30.0,
            color: Colors.blue,
          ),
        ),
        Container(
          child: ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.fromLTRB(0, 0, 0, 50),
            itemCount: medicationList.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  leading: Icon(medicationList[index]
                      .getMedication()
                      .getMedicationIcon()),
                  //TODO link to database
                  title: Text(
                    medicationList[index].getMedication().getName(),
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Checkbox(
                        value: medicationList[index]
                            .getMedication()
                            .getHasMedBeenTaken(),
                        onChanged: (bool newValue) {
                          checkboxState(index);
                        },
                      ),
                      FlatButton.icon(
                        icon: Icon(
                          Icons.info_outline,
                        ),
                        label: Text('info'),
                        onPressed: () {
                          navigateToMedicationDetails(medicationList[index]);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  /// Changes checkbox state depending on whether medication has been taken.
  void checkboxState(int index) {
    setState(() {
      medicationList[index]
          .getMedication()
          .setHasMedBeenTaken(!medicationList[index]
          .getMedication()
          .getHasMedBeenTaken());
    });
  }

  /// Pushes Add Medication Screen to top of the stack to display to user.
  void navigateToAddMedication() {
    Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) => AddMedicationScreen(user.getDummyUser())))
        .then((value) {
      setState(() {});
    });
  }

  /// Pushes Medication Details Screen for Medication at [index] to display to user.
  void navigateToMedicationDetails(MedicationRegime medication) {
    // TODO Firestore Integration
    Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) =>
                    MedicationDetails(medication, user.getDummyUser())))
        .then((value) {
      setState(() {});
    });
  }
}
