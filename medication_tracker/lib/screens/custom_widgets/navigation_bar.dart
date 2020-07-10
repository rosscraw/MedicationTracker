import 'package:flutter/material.dart';
import 'package:medicationtracker/screens/adherence/adherence_screen.dart';
import 'package:medicationtracker/screens/calendar/calendar_screen.dart';
import 'package:medicationtracker/screens/home/home_screen.dart';
import 'package:medicationtracker/screens/medication_list/medication_list_screen.dart';

/// Bottom navigation bar that changes displayed screen when user clicks on a tab.
class MedicationTrackerNavBar extends StatefulWidget {

  @override
  _MedicationTrackerNavBarState createState() => _MedicationTrackerNavBarState();
}

class _MedicationTrackerNavBarState extends State<MedicationTrackerNavBar> {
  int _currentIndex = 0;

  final List<Widget> _navTabs = [
    HomeScreen(title: 'Home'),
    MedicationScreen(title: 'Medication List'),
    CalendarScreen(title: 'Calendar'),
    AdherenceScreen(title: 'Adherence')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _navTabs[_currentIndex],
      ),
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

