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
import 'package:async/async.dart';

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

  Future fetchMedicationList;

  @override
  void initState() {
    final user = Provider.of<User>(context, listen: false);
    FirestoreDatabase firestoreDatabase = new FirestoreDatabase(user: user);
    fetchMedicationList = firestoreDatabase.getMedicationList();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final user = Provider.of<User>(context, listen: false);
    FirestoreDatabase firestoreDatabase = new FirestoreDatabase(user: user);
    fetchMedicationList = firestoreDatabase.getMedicationList();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: 500.0,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 60),
              child: buildMedicationListFromFirestore(user),
            ),
          ),
        ),
      ),
      floatingActionButton: addMedicationButton(user),
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

  Widget buildMedicationListFromFirestore(User user) {
    return FutureBuilder(
        initialData: fetchMedicationList,
        future: fetchMedicationList,
        builder: (context, medicationList) {
          if (medicationList.connectionState == ConnectionState.waiting) {
            return LoadingSpinner();
          } else {
            return ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: user.getMedicationList().length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: Icon(user.getMedicationList()[index].getMedication().getMedicationIcon()),
                      title: Text(user.getMedicationList()[index].getMedication().getName(),
                        style: TextStyle(fontSize: 20.0,),
                      ),
                      subtitle: Text(user.getMedicationList()[index].getDosage() + user.getMedicationList()[index].getDosageUnits(),
                        style: TextStyle(
                          fontSize: 15.0,
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
                                  value: controller.checkboxInitialState(user.getMedicationList()[index]),
                                  onChanged: (bool newValue) {
                                    checkboxState(user, user.getMedicationList()[index]);
                                  },
                                ),
                              ),
                              Expanded(
                                  child: Text('All Taken?',
                                      style: Theme.of(context).textTheme.bodyText1)),
                            ],
                          ),
                          FlatButton.icon(
                            icon: Icon(Icons.info_outline,
                            ),
                            label: Text('info'),
                            onPressed: () {
                              navigateToMedicationDetails(user.getMedicationList()[index], user);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                });
          }
        });
  }

  /// Changes checkbox state depending on whether medication has been taken.
  /// If medication has more than one dosage, all dosages must be checked off to be true.
  void checkboxState(User user, MedicationRegime medicationRegime) {
    setState(() {
      controller.setMedicationTaken(medicationRegime);
      FirestoreDatabase firestore = new FirestoreDatabase(user: user);
      firestore.editMedicationTaken(medicationRegime);
      if (medicationRegime
          .getDosageTimings()
          .isNotEmpty) {
        for (DoseTimeDetail time in medicationRegime.getDosageTimings()) {
          FirestoreDatabase firestore = new FirestoreDatabase(user: user);
          firestore.editDosageTaken(time);
        }
      }
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
