import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {



  final Color color;
  final String title;

  HomeScreen({Key key, this.title, this.color}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
        child: Text("Home"),
    );
  }
}


