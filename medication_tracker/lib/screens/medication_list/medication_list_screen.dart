import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicationtracker/controllers/medication_list_controller.dart';
import 'package:medicationtracker/models/dose_time_details.dart';
import 'package:medicationtracker/models/medication.dart';
import 'package:medicationtracker/models/medication_regime.dart';
import 'package:medicationtracker/models/user.dart';
import 'package:medicationtracker/screens/custom_widgets/loading_spinner.dart';
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
  MedicationListController controller = new MedicationListController();
  FirestoreDatabase firestoreDatabase = new FirestoreDatabase();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamProvider<QuerySnapshot>.value(
      value: FirestoreDatabase().trackerUsers,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: SizedBox(
              width: 500.0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: buildMedicationListFromFirestore(user),
              ),
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

  /// Uses Firestore to build a medication list
  Widget buildMedicationListFromFirestore(User user) {
    FirestoreDatabase firestore = new FirestoreDatabase(uid: user.getUid());
    return FutureBuilder(
        initialData: 0,
      future: firestore.getUserSnapshot(user),
      builder: (context, userSnapshot) {
        if (userSnapshot.connectionState == ConnectionState.waiting) {
          return LoadingSpinner();
        }
        else {
      return ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
        itemCount: userSnapshot.data['medication'].length,//userSnapshot.data['medication'].length,
        itemBuilder: (context, index) {
        return FutureBuilder(
          future: firestore.getMedicationSnapshotAtIndex(user, index),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return LoadingSpinner();
            } else if (snapshot.connectionState == ConnectionState.done ||
                snapshot.connectionState == ConnectionState.active){
            List<MedicationRegime> medicationList = [];
            Medication medication =
            new Medication(snapshot.data['name'], snapshot.data['type']);
            MedicationRegime medicationRegime = new MedicationRegime(
                medicationID: userSnapshot.data['medication'][index].toString(),
                medication: medication,
                dosage: snapshot.data['dosage'],
                dosageUnits: snapshot.data['units']);
            medicationRegime.setAllMedsTaken(snapshot.data['all taken']);
            medicationList.add(medicationRegime);
            user.setMedicationList(medicationList);
            return Card(
              child: ListTile(
                leading: Icon(medicationRegime
                    .getMedication()
                    .getMedicationIcon()),
//                //TODO link to database
                title: Text(
                  medicationRegime.getMedication().getName(),
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Checkbox(
                            activeColor: Colors.green,
                            value: controller.checkboxInitialState(medicationRegime),
                            onChanged: (bool newValue) {
                              checkboxState(user, medicationRegime);
                            },
                          ),
                        ),
                        Expanded(
                            child: Text('All Taken?',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1)),
                      ],
                    ),
                    FlatButton.icon(
                      icon: Icon(
                        Icons.info_outline,
                      ),
                      label: Text('info'),
                      onPressed: () {
                        navigateToMedicationDetails(
                            medicationRegime, user);
                      },
                    ),
                  ],
                ),
              ),
            );
          }
            else {
              return null;
            }
        },
        );}
      );}}
    );
  }



  /// Changes checkbox state depending on whether medication has been taken.
  /// If medication has more than one dosage, all dosages must be checked off to be true.
  void checkboxState(User user, MedicationRegime medicationRegime) {
    setState(() {
      controller.setMedicationTaken(medicationRegime);
      FirestoreDatabase firestore = new FirestoreDatabase(uid: user.getUid());
      firestore.editMedicationTaken(medicationRegime);
    });
  }

  /// Pushes Add Medication Screen to top of the stack to display to user.
  void navigateToAddMedication(User user) {
    Navigator.push(context,
            new MaterialPageRoute(builder: (context) => AddMedicationScreen()))
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
            builder: (context) => MedicationDetails(medication))).then((value) {
      setState(() {});
    });
  }
}
