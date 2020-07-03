import 'package:flutter/material.dart';

class SetDosageTimes extends StatefulWidget {
  @override
  _SetDosageTimesState createState() => _SetDosageTimesState();
}

class _SetDosageTimesState extends State<SetDosageTimes> {

  List<DateTime> dosageTimes;
  int number = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text('Set Dosage Times'),
          ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: number,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  leading: setDeleteIcon(index),
                  title: Center(child: Text('timepicker')),
                  trailing: setAddIcon(index),
              ),
              );
            },
          ),
        ],
      )

    );
  }
  void addDosageTime(DateTime time) {
    dosageTimes.add(time);
  }

  FlatButton setDeleteIcon(int index) {
    if(number - 1 == index && index > 0) {
      return FlatButton.icon(
          onPressed: () {
            if(number > 1) {
              number--;
            }
            setState(() {

            });
          },
          icon: Icon(Icons.delete),
          label: Text(
              'remove'
          )
      );
    }
    else {
      return null;
    }
  }

  FlatButton setAddIcon(int index) {
    if(number - 1 == index) {
      return FlatButton.icon(
          onPressed: () {
              number++;
            setState(() {

            });
          },
          icon: Icon(Icons.add),
          label: Text(
              'add'
          )
      );
    }
    else {
      return null;
    }
  }
}
