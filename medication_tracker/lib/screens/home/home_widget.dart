import 'package:flutter/material.dart';
import 'package:medicationtracker/back_end/user.dart';
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

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          // Sign out icon button in app bar.
//          FlatButton.icon(
//              onPressed: () async{
//                await _auth.signOut();
//              },
//              icon: Icon(
//                Icons.person,
//                color: Colors.white
//              ),
//              label: Text(
//                  'Logout',
//                  style: TextStyle(
//                      color: Colors.white,
//                  ),
//                ),
//              ),
          PopupMenuButton<String>(
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {'Settings', 'Logout'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ]
      ),
      body: MedicationTrackerNavBar(),
    );
  }

  void handleClick(String value) async{
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