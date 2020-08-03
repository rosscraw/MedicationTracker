import 'package:flutter/material.dart';
import 'package:medicationtracker/controllers/adherence_screen_controller.dart';
import 'package:medicationtracker/models/adherence_figures.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:medicationtracker/models/user.dart';
import 'package:medicationtracker/screens/custom_widgets/loading_spinner.dart';
import 'package:medicationtracker/services/firestore_database.dart';
import 'package:provider/provider.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';


class AdherenceScreen extends StatefulWidget {
  final String title;
  AdherenceScreen({Key key, this.title}) : super(key: key);

  @override
  _AdherenceScreenState createState() => _AdherenceScreenState();
}

class _AdherenceScreenState extends State<AdherenceScreen> {
  AdherenceScreenController controller = new AdherenceScreenController();
  int taken;
  int total;



  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<User>(context);





    return Container(
      child: SingleChildScrollView(
        child: SizedBox(
          width: 500,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Card(
                    child: ListTile(
                      leading: Icon(Icons.check),
                        title: Text('Taken: ' + controller.getTaken(_user).toString()))),
                Card(
                    child: ListTile(
                        leading: Icon(Icons.format_list_numbered),
                        title: Text('Total: ' + controller.getTotal(_user).toString()))),
                SizedBox(
                  height: 20,
                ),
                CircularPercentIndicator(
                  radius: 150.0,
                  lineWidth: 10.0,
                  percent: getPercentageTaken(_user),
                  center: new Text((getPercentageTaken(_user) * 100 ).toString() +'% taken'),
                  progressColor: Colors.green,
                ),

              ],
            ),
          ),
        ),
      )
    );
  }

  double getPercentageTaken(User user) {
    return controller.getTaken(user)/controller.getTotal(user);
  }

}