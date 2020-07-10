import 'package:flutter/material.dart';
import 'package:medicationtracker/back_end/dose_time_details.dart';
import 'package:medicationtracker/back_end/medication.dart';
import 'package:medicationtracker/back_end/medication_regime.dart';
import 'package:medicationtracker/back_end/user.dart';
import 'package:medicationtracker/dummy_data/dummy_user.dart';
import 'package:medicationtracker/screens/custom_widgets/set_dosage_times.dart';
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
  //static final user = new DummyUser(); // Dummy Data
  //var medicationList = user.getDummyUser().getMedicationList(); // Dummy Data

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamProvider<QuerySnapshot>.value(
      value: FirestoreDatabase().trackerUsers,
      child: Scaffold(
        body: Center(
          child: SizedBox(
            width: 500.0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: getMedicationListView(user),
            ),
          ),
        ),
        floatingActionButton: addMedicationButton(user),
      ),
    );
  }

  /// Add medication floating action button.
  FloatingActionButton addMedicationButton(User user) {
    return FloatingActionButton.extended(
      onPressed: () {
        navigateToAddMedication(user);
      },
      label: Text('Add Medication'),
      tooltip: 'Add Medication',
      icon: Icon(Icons.add),
    );
  }

  /// Column that contains text and the Listview that displays all user's medications with checkboxes.
  Column getMedicationListView(User user) {
    List<MedicationRegime> medicationList = user.getMedicationList();
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
                        value: checkboxInitialState(index, user),
//                        medicationList[index]
//                            .getMedication()
//                            .getHasMedBeenTaken(),
                        onChanged: (bool newValue) {
                          checkboxState(index, user);
                        },
                      ),
                      FlatButton.icon(
                        icon: Icon(
                          Icons.info_outline,
                        ),
                        label: Text('info'),
                        onPressed: () {
                          navigateToMedicationDetails(medicationList[index], user);
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

  /// Determines the initial state of the checkbox when screen is loaded.
  bool checkboxInitialState(int index, User user) {
    List<MedicationRegime> medicationList = user.getMedicationList();
    return medicationList[index].getAllMedsTaken();
  }

  /// Changes checkbox state depending on whether medication has been taken.
  /// If medication has more than one dosage, all dosages must be checked off to be true.
  void checkboxState(int index, User user) {
    List<MedicationRegime> medicationList = user.getMedicationList();
    setState(() {
      setState(() {
        medicationList[index]
            .setAllMedsTaken(!medicationList[index].getAllMedsTaken());
      });
    });
  }

  /// Pushes Add Medication Screen to top of the stack to display to user.
  void navigateToAddMedication(User user) {
    Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) => AddMedicationScreen()))
        .then((value) {
      setState(() {});
    });
  }

  /// Pushes Medication Details Screen for Medication at [index] to display to user.
  void navigateToMedicationDetails(MedicationRegime medication, User user) {
    // TODO Firestore Integration
    Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) =>
                    MedicationDetails(medication)))
        .then((value) {
      setState(() {});
    });
  }
}
