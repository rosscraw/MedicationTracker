import 'package:flutter/material.dart';
import 'package:medicationtracker/back_end/user.dart';
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
  int _currentIndex = 0;

  // List of screens accessible by the bottom navigation bar.
  final List<Widget> _children = [
    HomeScreen(title: 'Home', color: Colors.blue),
    MedicationScreen(title: 'Medication List'),
    CalendarScreen(title: 'Calendar', color: Colors.blue),
    AdherenceScreen(title: 'Adherence', color: Colors.yellowAccent)
  ];

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
      body: Center(
        child: _children[_currentIndex],
      ),
      // Bottom navigation bar with tabs for the Home, Medication List, Calendar and Adherence screens.
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: onTabTapped,
        currentIndex: _currentIndex, // this will be set when a new tab is tapped
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            title: new Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.local_pharmacy),
            title: new Text('Medications'),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              title: Text('Calendar')
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.show_chart),
              title: Text('Adherence')
          )
        ],
      ),
    );
  }

  /// Sets the state so that the current index is that of the tab tapped in the bottom navigation bar.
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}