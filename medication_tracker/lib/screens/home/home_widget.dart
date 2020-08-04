import 'package:flutter/material.dart';
import 'package:medicationtracker/models/user.dart';
import 'package:medicationtracker/screens/custom_widgets/navigation_bar.dart';
import 'package:medicationtracker/screens/settings/settings_screen.dart';
import 'package:medicationtracker/services/firebase_authentication.dart';

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
  final FirebaseAuthentication _auth = FirebaseAuthentication();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.title), actions: <Widget>[popupMenuButton()]),
      body: MedicationTrackerNavBar(),
    );
  }

  /// PopUp Menu button for the app bar.
  /// Allows user to access settings and Log out of application.
  PopupMenuButton popupMenuButton() {
    return PopupMenuButton<String>(
      onSelected: onClick,
      itemBuilder: (BuildContext context) {
        return {'Settings', 'Logout'}.map((String choice) {
          return PopupMenuItem<String>(
            value: choice,
            child: Text(choice),
          );
        }).toList();
      },
    );
  }

  /// This handles the Pop Up Menu's options and selection.
  void onClick(String value) async {
    switch (value) {
      case 'Logout':
        await _auth.signOut();
        break;
      case 'Settings':
        navigateToSettings();
    }
  }

  /// Pushes settings screen to top of stack.
  void navigateToSettings() {
    Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) => SettingsScreen(title: 'Settings')))
        .then((value) {
      setState(() {});
    });
  }
}
