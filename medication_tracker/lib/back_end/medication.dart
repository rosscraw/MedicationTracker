
/// Represents a medication that a User may have in their medication list.
class Medication{

  String _name;
  String _dosage;
  bool _hasMedBeenTaken = false;

  Medication(String name, String dosage) {
    setName(name);
    setDosage(dosage);
  }

  String getName() {
    return _name;
  }

  void setName(String name) {
    _name = name;
  }

  String getDosage() {
    return _dosage;
  }

  void setDosage(String dosage) {
    _dosage = dosage;
  }

  bool getHasMedBeenTaken() {
    return _hasMedBeenTaken;
  }

  void setHasMedBeenTaken(bool hasBeenTaken) {
    _hasMedBeenTaken = hasBeenTaken;
  }

}

