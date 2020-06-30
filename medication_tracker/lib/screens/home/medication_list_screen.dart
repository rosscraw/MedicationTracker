import 'package:flutter/material.dart';
import 'package:medicationtracker/back_end/medication.dart';
import 'package:medicationtracker/back_end/user.dart';
import 'package:medicationtracker/dummy_data/dummy_user.dart';
import 'package:medicationtracker/screens/home/add_medication.dart';
import'medication_details_screen.dart';
import 'package:medicationtracker/services/firestore_database.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medicationtracker/dummy_data/constants.dart';

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
        body: Container(
            child: ListView.builder(
              itemCount: dummyList.length,
              itemBuilder: (context, index) {
                return ListTile(
                    leading: Icon(Icons.healing),
                    //TODO link to database
                    title: Text(dummyList[index].getName()),
                    trailing: Checkbox(
                      value: dummyList[index].getHasMedBeenTaken(),
                      onChanged: (bool newValue) {
                        setState(() {
                          dummyList[index].setHasMedBeenTaken(!dummyList[index].getHasMedBeenTaken());
                        });
                      },
                    ),
                    onTap: () {
                      // TODO Firestore Integration
                      Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => MedicationDetails(dummyList[index], dummyUser.getDummyUser()))
                      ).then((value) {
                      setState(() {

                      });
                      });
                    }
                );
              },
            ),
        ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => AddMedicationScreen(dummyUser.getDummyUser()))
              ).then((value) {
                setState(() {

                });
              });
            },
            tooltip: 'Add Medication',
            child: Icon(Icons.add),
          ),
      ),
    );
  }
}
