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

}