import 'package:flutter/material.dart';
import 'package:medicationtracker/models/user.dart';
import 'package:medicationtracker/screens/check_sign_in_state.dart';
import 'package:medicationtracker/services/firebase_authentication.dart';
import 'package:medicationtracker/themes/app_themes.dart';
import 'package:medicationtracker/themes/dark_mode_notifier.dart';
import 'package:provider/provider.dart';

void main() => runApp(
      ChangeNotifierProvider<DarkModeNotifier>(
        create: (context) => DarkModeNotifier(),
        child: MedicationTrackerApp(),
      ),
    );

/// Application Root.
class MedicationTrackerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<DarkModeNotifier>(
        builder: (context, darkModeNotifier, child) {
      return StreamProvider<User>.value(
        value: FirebaseAuthentication().user,
        child: MaterialApp(
          title: 'Medication Tracker App',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode:
              darkModeNotifier.isDarkModeOn ? ThemeMode.dark : ThemeMode.light,
          home: CheckSignInState(),
          //home: HomeWidget(title: 'MedTracker3000',),
        ),
      );
    });
  }
}
