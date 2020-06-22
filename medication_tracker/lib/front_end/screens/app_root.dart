import 'package:flutter/material.dart';
import 'home_widget.dart';
import 'medication_list_screen.dart';

void main() {
  runApp(MedicationTrackerApp());
}


class MedicationTrackerApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Medication Tracker App',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeWidget(title: "Medication Tracker"),
    );
  }
}