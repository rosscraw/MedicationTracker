import 'package:flutter/material.dart';
import 'package:medicationtracker/back_end/user.dart';
import 'package:medicationtracker/screens/authenticate/log_in_screen.dart';
import 'package:medicationtracker/screens/check_sign_in_state.dart';
import 'package:medicationtracker/services/firebase_authentication.dart';
import 'package:medicationtracker/themes/app_themes.dart';
import 'package:medicationtracker/themes/dark_mode_notifier.dart';
import 'package:provider/provider.dart';
import 'screens/home/home_widget.dart';
import 'screens/medication_list/medication_list_screen.dart';
import 'package:medicationtracker/screens/authenticate/authentication.dart';

//void main() => runApp(
//  //runApp(MedicationTrackerApp());
//  ChangeNotifierProvider<DarkModeNotifier>(
//    builder: (context) => DarkModeNotifier(),
//    child: MedicationTrackerApp(),
//  ));

void main() => runApp(
  ChangeNotifierProvider<DarkModeNotifier>(
    create: (context) => DarkModeNotifier(),
    child: MedicationTrackerApp(),
  ),
);

class MedicationTrackerApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<DarkModeNotifier>(
      builder: (context, darkModeNotifier, child) {return StreamProvider<User>.value(
        value: AuthService().user,
        child: MaterialApp(
          title: 'Medication Tracker App',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: darkModeNotifier.isDarkModeOn ? ThemeMode.dark : ThemeMode.light,
          home: CheckSignInState(),
          //home: HomeWidget(title: 'MedTracker3000',),
        ),
      );}
    );
  }
}