import 'package:medicationtracker/models/adherence_figures.dart';
import 'package:medicationtracker/models/user.dart';

class AdherenceScreenController {

  AdherenceFigures adherenceFigures = new AdherenceFigures();

  int getTotal(User user) {
    adherenceFigures.setUser(user);
    return adherenceFigures.getTotalMedications();
  }

  int getTaken(User user) {
    adherenceFigures.setUser(user);
    return adherenceFigures.getTotalTakenMedications();
  }

  double getPercentageTaken(User user) {
    if(user.getMedicationList().length > 0) {
      return ((getTaken(user) / getTotal(user) ) * 10000).roundToDouble() / 10000;
    }
    else {
      return 0;
    }
  }


}