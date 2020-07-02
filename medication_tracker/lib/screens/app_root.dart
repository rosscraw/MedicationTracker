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
//          primaryColor: Colors.blue,
//          backgroundColor: Colors.blue[50],
//          scaffoldBackgroundColor: Colors.blue[50],
//          cardColor: Colors.blue[100],

          visualDensity: VisualDensity.adaptivePlatformDensity,
//          colorScheme: ColorScheme(
//            primary: Colors.blue[800],
//            primaryVariant: Colors.blueGrey,
//            secondary: Colors.blueAccent,
//            secondaryVariant: Colors.blueGrey,
//            surface: Colors.blue[100],
//            background: Colors.blue[500],
//            error: Colors.red,
//            onPrimary: Colors.black,
//            onSecondary: Colors.white,
//            onSurface: Colors.black,
//            onBackground: Colors.black,
//            onError: Colors.white,
//            brightness: Brightness.light
//          ),

        ),
        home: CheckSignInState(),
      ),
    );
  }
}