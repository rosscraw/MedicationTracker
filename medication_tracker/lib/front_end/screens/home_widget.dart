import 'package:flutter/material.dart';
import 'package:medicationtracker/front_end/screens/adherence_screen.dart';
import 'package:medicationtracker/front_end/screens/medication_list_screen.dart';
import 'package:medicationtracker/main.dart';
import 'medication_list_screen.dart';
import 'calendar_screen.dart';
import 'adherence_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int _currentIndex = 0;
  final List<Widget> _children = [
    HomeScreen(),
    MedicationScreen(title: 'Medication List'),
    CalendarScreen(Colors.blue),
    AdherenceScreen(Colors.yellowAccent)
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _children[_currentIndex],

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

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}