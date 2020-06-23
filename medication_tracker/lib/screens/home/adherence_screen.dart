import 'package:flutter/material.dart';

class AdherenceScreen extends StatelessWidget {
  final Color color;
  final String title;
  AdherenceScreen({Key key, this.title, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
    );
  }
}