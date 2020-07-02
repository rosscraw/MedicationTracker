import 'package:flutter/material.dart';
import 'package:medicationtracker/back_end/user.dart';
import 'package:medicationtracker/screens/custom_widgets/navigation_bar.dart';
import 'package:medicationtracker/services/firebase_authentication.dart';
import 'package:medicationtracker/screens/medication_list/medication_list_screen.dart';
import 'package:medicationtracker/screens/adherence/adherence_screen.dart';
import 'package:medicationtracker/screens/calendar/calendar_screen.dart';
import 'home_screen.dart';

/// Represents the scaffold for the main section of the app.
/// Contains the app bar and navigation bar, as well as the screen that is currently displayed.
class HomeWidget extends StatefulWidget {
  HomeWidget({Key key, this.title, this.user}) : super(key: key);

  final String title;
  final User user;

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          // Sign out icon button in app bar.
          FlatButton.icon(
              onPressed: () async{
                await _auth.signOut();
              },
              icon: Icon(
                Icons.person,
                color: Colors.white
              ),
              label: Text(
                  'Logout',
                  style: TextStyle(
                      color: Colors.white,
                  ),
                ),
              ),
        ]
      ),
      body: MedicationTrackerNavBar(),
    );
  }
}