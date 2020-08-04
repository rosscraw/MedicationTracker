import 'package:flutter/material.dart';
import 'package:medicationtracker/models/user.dart';
import 'package:medicationtracker/screens/authenticate/authentication.dart';
import 'package:medicationtracker/screens/custom_widgets/loading_spinner.dart';
import 'package:medicationtracker/screens/home/home_screen.dart';
import 'package:medicationtracker/screens/home/home_widget.dart';
import 'package:medicationtracker/services/firestore_database.dart';
import 'package:provider/provider.dart';

/// Checks if user is signed in.
/// If signed it will show the Home Screen.
/// If not signed in it will show the Log In Screen.
class CheckSignInState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(user);

    // If there is no user being provided show Log In Screen.
    if (user == null) {
      return Authentication();
    }
    // If user is provided show Home Screen.
    else {
      FirestoreDatabase firestore = FirestoreDatabase(uid: user.getUid());

      return FutureBuilder(
          future: firestore.getMedicationList(user),
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
