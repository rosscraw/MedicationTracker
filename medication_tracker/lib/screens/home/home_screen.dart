import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medicationtracker/models/user.dart';
import 'package:medicationtracker/screens/custom_widgets/medication_times_list.dart';
import 'package:provider/provider.dart';
import 'package:medicationtracker/controllers/home_controller.dart';

/// Home screen of the application.
/// First screen visible after log in.
/// Shows user any medications that are due to be taken within the next two hours.
class HomeScreen extends StatefulWidget {

  final String title;


  HomeScreen({Key key, this.title}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //var dummyList = HomeScreen.user.getDummyUser().getMedicationList();
  HomeController controller = new HomeController();

  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<User>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: 500.0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  overdueList(_user),
                  dueList(_user),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Shows list if there are any overdue medications.
  /// Shows text informing user none are overdue if there are no overdue meds.
  Widget overdueList(User user) {
    if (controller.getOverdueMedications(user).isEmpty) {
      return Card(
        child: ListTile(
          leading: Icon(Icons.alarm_on, color: Colors.green),
          title: Text(
            'No medications are overdue!',
              //style: Theme.of(context).textTheme.bodyText2
          ),
        ),
      );
    } else {
      return Column(
        children: [
          Text(
            'Overdue Medications',
              style: Theme.of(context).textTheme.headline5
          ),
          MedicationTimesList(controller.getOverdueMedications(user)),
        ],
      );
    }
  }

  /// Shows list if there are any medications due soon.
  /// Shows text informing user none are due if there are none due soon.
  Widget dueList(User user) {
    if (controller.getDueMedications(user).isEmpty) {
      return Card(
        child: ListTile(
          leading: Icon(Icons.alarm_on, color: Colors.green,),
          title: Text(
            'No medications are due soon!',
              //style: Theme.of(context).textTheme.bodyText2
          ),
        ),
      );
    } else {
      return Column(
        children: [
          Text(
            "Medications Due Soon",
            style: Theme.of(context).textTheme.headline5,
          ), //
          MedicationTimesList(controller.getDueMedications(user)),
        ],
      );
    }
  }


}
