import 'package:flutter/material.dart';

class SetDosageTimes extends StatefulWidget {
  @override
  _SetDosageTimesState createState() => _SetDosageTimesState();
}

class _SetDosageTimesState extends State<SetDosageTimes> {

  List<TimeOfDay> dosageTimes = [];
  TimeOfDay chosenTime;
  int number = 1;
  bool timeSelected = false;

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
                  title: setAddTimeButton(index),
                  trailing: setAddIcon(index),
              ),
              );
            },
          ),
        ],
      )

    );
  }
  Column setDeleteIcon(int index) {
    if(number - 1 == index && index > 0) {
      return Column(
        children: [
          IconButton(
              onPressed: () {
                if(number > 1) {
                  number--;
                }
                setState(() {

                });
              },
              icon: Icon(Icons.delete),
          ),
//          Text(
//              'remove'
//          ),
        ],
      );
    }
    else {
      return null;
    }
  }

  Column setAddIcon(int index) {
    if(number - 1 == index) {
      return Column(
        children: [
          IconButton(
              onPressed: () {
                  number++;
                setState(() {

                });
              },
              icon: Icon(Icons.add),

          ),
//          Text(
//              'add'
//          )
        ],
      );
    }
    else {
      return null;
    }
  }

//  FlatButton setAddTimeButton(int index) {
////    if (dosageTimes.isEmpty) {
////      return FlatButton.icon(
////        icon: Icon(
////          Icons.alarm_add,
////        ),
////        label: Text('Add dosage time'),
////        onPressed: () async{
////          selectDosageTime(context, index);
////        },
////      );
////    }
////    else {
////      return FlatButton.icon(
////        icon: Icon(
////          Icons.alarm_add,
////        ),
////        label: Text(dosageTimes[index].format(context)),
////        onPressed: () async{
////          selectDosageTime(context, index);
////        },
////      );
////    }
////  }

  Column setAddTimeButton(int index) {
    if (dosageTimes.isEmpty) {
      return Column(
        children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.alarm_add,
            ),
            onPressed: () async{
              selectDosageTime(context, index);
            },
          ),
          Text('Add dosage time'),
        ],
      );
    }
    else {
      return Column(
        children: <Widget>[
          FlatButton.icon(
            icon: Icon(
              Icons.alarm_add
            ),
            label: Text(dosageTimes[index].format(context)),
            onPressed:() async{
              selectDosageTime(context, index);
            },
          ),
        ],
      );
    }
  }


  Future<Null> selectDosageTime(BuildContext context, int index) async {
    TimeOfDay chosenTime = await showTimePicker(context: context, initialTime: (TimeOfDay(hour: 12, minute: 0)));
    setState(() {
      //print(dosageTimes[index].format(context));
      timeSelected = true;
      if(dosageTimes[index] == null || dosageTimes.isEmpty) {
        dosageTimes.add(chosenTime);
      }
      else {
        dosageTimes[index] = chosenTime;
      }
    });
  }

  List<TimeOfDay> getDosageTimes() {
    return dosageTimes;
  }
}
