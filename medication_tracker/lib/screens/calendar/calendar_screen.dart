import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

/// Screen in which the [User] can select a date.
class CalendarScreen extends StatefulWidget {
  final Color color;
  final String title;

  CalendarScreen({Key key, this.title, this.color}) : super(key: key);

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}



class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _dateTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(_dateTime == null ? 'Nothing has been picked yet' : _dateTime
                .toString()),
            RaisedButton(
              child: Text('Pick a date', style: TextStyle(color: Colors.white),),
              onPressed: () {
                showDatePicker(
                    context: context,
                    initialDate: _dateTime == null ? DateTime.now() : _dateTime,
                    firstDate: DateTime(2020, 6),
                    lastDate:  DateTime.now()
                ).then((date) {
                  setState(() {
                    _dateTime = date;
                  });
                });
              },
            )
          ],
        ),
      ),
    );
  }
}