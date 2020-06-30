import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicationtracker/back_end/medication.dart';
import 'package:medicationtracker/back_end/user.dart';
import 'package:medicationtracker/screens/home/medication_list_screen.dart';



class AddMedicationScreen extends StatefulWidget {

  final User user;

  AddMedicationScreen(this.user);

  @override
  _AddMedicationScreenState createState() => _AddMedicationScreenState();
}

class _AddMedicationScreenState extends State<AddMedicationScreen> {
  String medicationName = '';
  String  medicationDosage = '';
  final _medFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Add new Medication')
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 50.0),
            child: Column(
              children: [
                SizedBox(
                  height: 10.0,
                ),
                Form (
                  key: _medFormKey,
                  child: Column(
                    children: [
                      TextFormField(
                          validator: (val) => val.isEmpty ? "Please enter your medication's name" : null,
                          decoration: InputDecoration(
                            labelText: 'Medication Name',
                          ),
                          onChanged: (val) {
                            setState(() => medicationName = val);
                          }
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                          validator: (val) => val.isEmpty ? "Please enter your medication's dosage" : null,
                          decoration: InputDecoration(
                            labelText: 'Medication Dosage',
                          ),
                          onChanged: (val) {
                            setState(() => medicationDosage = val);
                          }
                      ),
                      SizedBox(height: 20.0),
                      RaisedButton(
                        color: Colors.blue,
                        child: Text(
                          'Add Medication',
                          style: TextStyle(color: Colors.white),
                        ),
                        // TODO add to medication to user's list.
                        onPressed: () {
                          if(_medFormKey.currentState.validate()) {
                            setState(() {
                            widget.user.addMedication(new Medication(medicationName, medicationDosage, ''));
                            Navigator.pop(context);
                          });
                          }
                        },
                      )
                    ],
                  )
                )
              ],
            ),
          ),
        )
      )
    );
  }
}
