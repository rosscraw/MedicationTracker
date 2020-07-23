import 'package:flutter/material.dart';
import 'package:medicationtracker/controllers/adherence_screen_controller.dart';
import 'package:medicationtracker/models/adherence_figures.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:medicationtracker/models/user.dart';
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
      child: Column(
        children: [
          Text('Taken: ' + getTaken(_user)),
          Text('Total: ' + getTotal(_user))
        ],
      )
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