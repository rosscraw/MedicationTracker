
import 'package:flutter/material.dart';
import 'package:medicationtracker/back_end/user.dart';
import 'package:medicationtracker/screens/authenticate/authentication.dart';
import 'package:medicationtracker/screens/home/home_screen.dart';
import 'package:medicationtracker/screens/home/home_widget.dart';
import 'package:provider/provider.dart';

class CheckSignInState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    print(user);

    // return either Home of login screen depending on if user is logged it
    if (user == null) {
      return Authentication();
    }
    else {
      return HomeWidget(title: 'MedTracker');
    }
  }
}
