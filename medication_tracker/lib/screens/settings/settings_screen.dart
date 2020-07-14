import 'package:flutter/material.dart';

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
    );
  }
}