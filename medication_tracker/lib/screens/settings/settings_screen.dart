import 'package:flutter/material.dart';
import 'package:medicationtracker/themes/dark_mode_notifier.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  final String title;
  SettingsScreen({Key key, this.title}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Dark Mode'),
          Switch(
            value: Provider.of<DarkModeNotifier>(context, listen: false).isDarkModeOn,
            onChanged: (bool) {
              setState(() {
                Provider.of<DarkModeNotifier>(context, listen: false).updateTheme(bool);
              });
            },
            activeTrackColor: Colors.lightGreenAccent,
            activeColor: Colors.green,
          ),
        ],
      ),
    );
  }
}
