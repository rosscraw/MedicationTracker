import 'package:flutter/material.dart';
import 'package:medicationtracker/back_end/adherence_figures.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:medicationtracker/dummy_data/dummy_user.dart';


class AdherenceScreen extends StatefulWidget {
  final String title;
  AdherenceScreen({Key key, this.title}) : super(key: key);

  @override
  _AdherenceScreenState createState() => _AdherenceScreenState();
}

class _AdherenceScreenState extends State<AdherenceScreen> {
  static final user = new DummyUser(); // Dummy Data
  var medicationList = user.getDummyUser().getMedicationList(); // Dummy Data



  @override
  Widget build(BuildContext context) {
    return Container(
    );
  }
}