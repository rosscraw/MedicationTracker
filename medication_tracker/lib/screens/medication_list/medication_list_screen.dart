import 'package:flutter/material.dart';
import 'package:medicationtracker/controllers/medication_list_controller.dart';
import 'package:medicationtracker/models/dose_time_details.dart';
import 'package:medicationtracker/models/medication.dart';
import 'package:medicationtracker/models/medication_regime.dart';
import 'package:medicationtracker/models/user.dart';
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
  MedicationListController controller = new MedicationListController();

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
                child: getMedicationListView(user),
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

  /// Column that contains text and the Listview that displays all user's medications with checkboxes.
  Column getMedicationListView(User user) {
    List<MedicationRegime> medicationList = user.getMedicationList();
    // Sort medications alphabetically by name.
    medicationList.sort((a, b) => a.getMedication().getName().toUpperCase().compareTo(b.getMedication().getName().toUpperCase()));

    return Column(
      children: [
        Text(
          'Medications',
          style: Theme.of(context).textTheme.headline5
          ),
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
                                value: controller.checkboxInitialState(index, user),
                                onChanged: (bool newValue) {
                                  checkboxState(index, user);
                                },
                              ),
                            ),
                            Expanded(child: Text('All Taken?',
                            style: Theme.of(context).textTheme.bodyText1)),
                          ],
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
