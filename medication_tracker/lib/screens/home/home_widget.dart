import 'package:flutter/material.dart';
import 'medication_list_screen.dart';
import 'adherence_screen.dart';
import 'calendar_screen.dart';
import 'home_screen.dart';

class HomeWidget extends StatefulWidget {
  HomeWidget({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {

  int _currentIndex = 0;
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
      ),
      body: Center(
        child: _children[_currentIndex],
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

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}