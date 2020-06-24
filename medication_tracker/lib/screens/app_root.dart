import 'package:flutter/material.dart';
import 'package:medicationtracker/back_end/user.dart';
import 'package:medicationtracker/screens/authenticate/log_in_screen.dart';
import 'package:medicationtracker/screens/check_sign_in_state.dart';
import 'package:medicationtracker/services/firebase_authentication.dart';
import 'package:provider/provider.dart';
import 'home/home_widget.dart';
import 'home/medication_list_screen.dart';
import 'package:medicationtracker/screens/authenticate/authentication.dart';

void main() {
  runApp(MedicationTrackerApp());
}


class MedicationTrackerApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        title: 'Medication Tracker App',
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: CheckSignInState(),
      ),
    );
  }
}