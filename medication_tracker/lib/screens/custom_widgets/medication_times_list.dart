import 'package:flutter/material.dart';
import 'package:medicationtracker/controllers/medication_times_list_controller.dart';
import 'package:medicationtracker/models/dose_time_details.dart';
import 'package:medicationtracker/models/medication_regime.dart';
import 'package:medicationtracker/models/user.dart';
import 'package:medicationtracker/services/firestore_database.dart';
import 'package:provider/provider.dart';

/// List widget used on [HomeScreen] to generate lists for due and overdue [DoseTimeDetail]s.
class MedicationTimesList extends StatefulWidget {
  MedicationTimesList(this.medications);

  final List<DoseTimeDetail> medications;

  @override
  _MedicationTimesListState createState() => _MedicationTimesListState();
}

class _MedicationTimesListState extends State<MedicationTimesList> {

  MedicationTimesListController controller = new MedicationTimesListController();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: widget.medications.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: Icon(controller.getMedicationIcon(widget.medications[index])),
              title: Text(
                controller.getMedicationNameAndTime(widget.medications[index], context),
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  // TODO fix functionality
                  Checkbox(
                    activeColor: Colors.green,
                    value: widget.medications[index].getHasMedBeenTaken(),
                    onChanged: (bool newValue) async {
                      checkboxState(index, user);

                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  /// Changes checkbox state depending on whether medication has been taken and removes from list.
  /// Small delay to allow checkbox animation to play.
  void checkboxState(int index, User user) {
    setState(() {
      controller.setMedicationBeenTaken(widget.medications[index]);
      FirestoreDatabase firestore = new FirestoreDatabase(user: user);
      firestore.editDosageTaken(widget.medications[index]);
      Future.delayed(Duration(milliseconds: 300), () {
        setState(() {
          controller.removeFromDueOrOverdueList(widget.medications, index);
        });
      });
    });
  }
}
