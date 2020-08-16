import 'package:flutter/material.dart';
import 'package:medicationtracker/models/user.dart';
import 'package:medicationtracker/screens/authenticate/authentication.dart';
import 'package:medicationtracker/screens/custom_widgets/loading_spinner.dart';
import 'package:medicationtracker/screens/home/home_screen.dart';
import 'package:medicationtracker/screens/home/home_widget.dart';
import 'package:medicationtracker/services/firestore_database.dart';
import 'package:provider/provider.dart';

/// Checks if [User] is signed in.
/// If signed it will show the [HomeScreen].
/// If not signed in it will show the [LogInScreen].
class CheckSignInState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    // If there is no user being provided show Log In Screen.
    if (user == null) {
      return Authentication();
    }
    // If user is provided show Home Screen.
    else {
      FirestoreDatabase firestore = FirestoreDatabase(user: user);

      return FutureBuilder(
          future: firestore.getMedicationList(),
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting) {
              return Scaffold(body: LoadingSpinner());
            }
            else {
              return HomeWidget(title: 'MedTracker', user: user);
            }
          });
    }
  }
}
