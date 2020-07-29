import 'package:flutter/material.dart';
import 'package:medicationtracker/controllers/adherence_screen_controller.dart';
import 'package:medicationtracker/models/adherence_figures.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:medicationtracker/models/user.dart';
import 'package:medicationtracker/screens/custom_widgets/loading_spinner.dart';
import 'package:medicationtracker/services/firestore_database.dart';
import 'package:provider/provider.dart';


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
              children: [
                Card(
                    child: ListTile(
                      leading: Icon(Icons.check),
                        title: Text('Taken: ' + getTaken(_user)))),
                Card(
                    child: ListTile(
                        leading: Icon(Icons.format_list_numbered),
                        title: Text('Total: ' + getTotal(_user)))),
                future(_user),

              ],
            ),
          ),
        ),
      )
    );
  }

  Widget future(User user) {
    FirestoreDatabase firestore = new FirestoreDatabase(uid: user.getUid());
    return FutureBuilder(
      future: firestore.getMedicationList(user),
      builder: (context, medicationList) {
        if(medicationList.connectionState == ConnectionState.waiting) {
          return LoadingSpinner();
        }
        else {
          return ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: medicationList.data.length,//userSnapshot.data['medication'].length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(medicationList.data[index].getMedication().getName()),
                  ),
                );
              }
          );
        }
      }
    );
  }

  String getTaken(User user) {
    setState(() {
      taken = controller.getTaken(user);
    });
    return taken.toString();
  }

  String getTotal(User user) {
    setState(() {
      total = controller.getTotal(user);
    });
    return total.toString();
  }


}