import 'package:flutter/material.dart';
import 'package:medicationtracker/back_end/medication.dart';
import 'package:medicationtracker/screens/home/add_medication.dart';
import'medication_details_screen.dart';
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


  List<String> dummyList = [
    "creon",
    "tresiba",
    "fiasp",
    "relvar elipta",
    "tiotropium",
    "symkevi",
    "kalydeco",
    "venotlin",
    "dornase alfa",
    "cayston",
    "colomycin"
  ];

  List<Medication> dummyList2 = [
    new Medication("creon", "100mg"),
    new Medication("tresiba", "100 units"),
    new Medication("fiasp", "100 units"),
    new Medication("ventolin", "100mg"),
    new Medication("adsfdgfhjh", "100mg"),
    new Medication("asgdhfgn", "100remg"),
  ];

  void _addMedication() {
    setState(() {
      dummyList2.add(new Medication("new med", "addition successful"));
    });
  }

  List<Medication> getDummyList() {
    return dummyList2;
  }

  void _removeMedication(Medication medication) {
    setState(() {
      dummyList2.remove(medication);
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<QuerySnapshot>.value(
      value: FirestoreDatabase().trackerUsers,
      child: Scaffold(
        body: Container(
            child: ListView.builder(
              itemCount: dummyList2.length,
              itemBuilder: (context, index) {
                return ListTile(
                    leading: Icon(Icons.healing),
                    title: Text(dummyList2[index].getName()),
                    trailing: Checkbox(
                      value: dummyList2[index].getHasMedBeenTaken(),
                      onChanged: (bool newValue) {
                        setState(() {
                          dummyList2[index].setHasMedBeenTaken(!dummyList2[index].getHasMedBeenTaken());
                        });
                      },
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => MedicationDetails(dummyList2[index]))
                      );
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
                      builder: (context) => AddMedicationScreen())
              );
            },
            tooltip: 'Add Medication',
            child: Icon(Icons.add),
          ),
      ),
    );
  }
}
