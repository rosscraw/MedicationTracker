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
                child: getMedicationListViewFromFirestore(user),
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

  Widget getMedicationListViewFromFirestore(User user) {
    FirestoreDatabase firestore = new FirestoreDatabase(uid: user.getUid());

    return FutureBuilder(
        future: firestore.getMedicationList(user),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingSpinner();
          } else if (snapshot.connectionState == ConnectionState.done ||
              snapshot.connectionState == ConnectionState.active) {
            //List<MedicationRegime> medicationList = snapshot.data ?? [];
            return ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.fromLTRB(0, 0, 0, 50),
              itemCount: snapshot.data['medication'].length,
              itemBuilder: (context, index) {
                return listTileFromFirestore(
                    snapshot.data['medication'][index], user, index);
              },
            );
          } else {
            return null;
          }
        });
  }

  Widget listTileFromFirestore(String medID, User user, int index) {
    FirestoreDatabase firestore = new FirestoreDatabase(uid: user.getUid());
    return FutureBuilder(
        future: firestore.getMedicationItem(medID),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingSpinner();
          } else if (snapshot.connectionState == ConnectionState.done ||
              snapshot.connectionState == ConnectionState.active) {
            List medicationList = [];
            Medication medication =
                new Medication(snapshot.data['name'], snapshot.data['type']);
            MedicationRegime medicationRegime = new MedicationRegime(
                medicationID: medID,
                medication: medication,
                dosage: snapshot.data['dosage'],
                dosageUnits: snapshot.data['units']);
            medicationRegime.setAllMedsTaken(snapshot.data['all taken']);
            medicationList.add(medicationRegime);
            medicationList.sort((a, b) => a
                .getMedication()
                .getName()
                .toUpperCase()
                .compareTo(b.getMedication().getName().toUpperCase()));
            return ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: medicationList.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: Icon(
                          medicationList[index].getMedication().getMedicationIcon()),
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
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
//                    Expanded(
//                      child: Checkbox(
//                        activeColor: Colors.green,
//                        value: controller.checkboxInitialState(
//                            index, user),
//                        onChanged: (bool newValue) {
//                          checkboxState(index, user);
//                        },
//                      ),
//                    ),
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
                                  medicationList[index], user);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                });
          } else {
            return null;
          }
        });
  }

//  Widget getMedicationListViewFromFirestore(User user) {
//    FirestoreDatabase firestore = new FirestoreDatabase(uid: user.getUid());
//
//    return FutureBuilder(
//      future: firestore.fetchMedications(user),
//      builder: (context, snapshot) {
//        if (snapshot.connectionState == ConnectionState.waiting) {
//          return LoadingSpinner();
//        } else if (snapshot.hasData) {
//          List medicationListIds = snapshot.data['medication'];
//
//          List<MedicationRegime> medicationList = [];
//
//          medicationListIds.forEach((element) async {
//            DocumentReference medicationIdRef =
//                Firestore.instance.collection('medications').document(element);
//            DocumentSnapshot medicationIdSnapshot = await medicationIdRef.get();
//
//            String a = await medicationIdSnapshot.data['name'];
//
//            Medication medication = new Medication(
//                medicationIdSnapshot.data['name'],
//                medicationIdSnapshot.data['type']);
//            MedicationRegime medicationRegime = new MedicationRegime(
//                medicationID: element.toString(),
//                medication: medication,
//                dosage: medicationIdSnapshot.data['dosage'],
//                dosageUnits: medicationIdSnapshot.data['units']);
//            medicationRegime
//                .setAllMedsTaken(medicationIdSnapshot.data['all taken']);
//            user.addMedication(medicationRegime);
//          });
//          print(user.getMedicationList().length);
//          return ListView.builder(
//            physics: NeverScrollableScrollPhysics(),
//            shrinkWrap: true,
//            padding: EdgeInsets.fromLTRB(0, 0, 0, 50),
//            itemCount: medicationList.length,
//            itemBuilder: (context, index) {
//              return Card(
//                child: Padding(
//                  padding: const EdgeInsets.all(4.0),
//                  child: ListTile(
//                    leading: Icon(medicationList[index]
//                        .getMedication()
//                        .getMedicationIcon()),
//                    //TODO link to database
//                    title: Text(
//                      medicationList[index].getMedication().getName(),
//                      style: TextStyle(
//                        fontSize: 20.0,
//                      ),
//                    ),
//                    trailing: Row(
//                      mainAxisSize: MainAxisSize.min,
//                      children: <Widget>[
//                        Column(
//                          mainAxisAlignment: MainAxisAlignment.center,
//                          crossAxisAlignment: CrossAxisAlignment.center,
//                          children: [
//                            Expanded(
//                              child: Checkbox(
//                                activeColor: Colors.green,
//                                value: controller.checkboxInitialState(
//                                    index, user),
//                                onChanged: (bool newValue) {
//                                  checkboxState(index, user);
//                                },
//                              ),
//                            ),
//                            Expanded(
//                                child: Text('All Taken?',
//                                    style:
//                                        Theme.of(context).textTheme.bodyText1)),
//                          ],
//                        ),
//                        FlatButton.icon(
//                          icon: Icon(
//                            Icons.info_outline,
//                          ),
//                          label: Text('info'),
//                          onPressed: () {
//                            navigateToMedicationDetails(
//                                medicationList[index], user);
//                          },
//                        ),
//                      ],
//                    ),
//                  ),
//                ),
//              );
//            },
//          );
//        } else {
//          return null;
//        }
//      },
//    );
//  }

  /// Column that contains text and the Listview that displays all user's medications with checkboxes.
  Column getMedicationListView(User user) {
    FirestoreDatabase firestore = new FirestoreDatabase(uid: user.getUid());
    setState(() {});
    List<MedicationRegime> medicationList = user.getMedicationList();
    if (medicationList.isEmpty) {
      setState(() {
        firestore.getMedicationList(user);
        medicationList = user.getMedicationList();
      });
    }

    // Sort medications alphabetically by name.
    medicationList.sort((a, b) => a
        .getMedication()
        .getName()
        .toUpperCase()
        .compareTo(b.getMedication().getName().toUpperCase()));

    return Column(
      children: [
        Text('Medications', style: Theme.of(context).textTheme.headline5),
        Container(
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.fromLTRB(0, 0, 0, 50),
            itemCount: medicationList.length,
            itemBuilder: (context, index) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
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
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Checkbox(
                                activeColor: Colors.green,
                                value: controller.checkboxInitialState(
                                    index, user),
                                onChanged: (bool newValue) {
                                  checkboxState(index, user);
                                },
                              ),
                            ),
                            Expanded(
                                child: Text('All Taken?',
                                    style:
                                        Theme.of(context).textTheme.bodyText1)),
                          ],
                        ),
                        FlatButton.icon(
                          icon: Icon(
                            Icons.info_outline,
                          ),
                          label: Text('info'),
                          onPressed: () {
                            navigateToMedicationDetails(
                                medicationList[index], user);
                          },
                        ),
                      ],
                    ),
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
  /// If medication has more than one dosage, all dosages must be checked off to be true.
  void checkboxState(int index, User user) {
    List<MedicationRegime> medicationList = user.getMedicationList();
    setState(() {
      controller.setMedicationTaken(medicationList[index]);
      FirestoreDatabase firestore = new FirestoreDatabase(uid: user.getUid());
      firestore.editMedicationTaken(medicationList[index]);
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
