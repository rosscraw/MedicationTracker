import 'package:flutter/material.dart';
import 'package:medicationtracker/themes/dark_mode_notifier.dart';
import 'package:provider/provider.dart';

/// Settings screen where user can:
/// - Switch between light and dark themes.
class SettingsScreen extends StatefulWidget {
  final String title;
  SettingsScreen({Key key, this.title}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  double fontSize = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Row(
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
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Text('Font Size'),
          Slider(
            value: fontSize,
            onChanged: (newFontSize) {
              setState(() {
                fontSize = newFontSize;
              });
            },
            divisions: 2,
            min: 0,
            max: 2,
            label: sliderLabel(fontSize),
          )
        ],
      ),
    );
  }

  String sliderLabel(double fontSize) {
    if(fontSize == 0) {
      return 'Small';
    }
    else if(fontSize == 1) {
      return 'Medium';
    }
    else {
      return 'Large';
    }
  }
}
