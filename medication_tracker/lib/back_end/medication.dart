
/// Represents a medication that a User may have in their medication list.
class Medication{

  String _name;
  String _dosage;
  String _medType;
  bool _hasMedBeenTaken = false;

  Medication(String name, String dosage, String medType) {
    setName(name);
    setDosage(dosage);
    setMedType(medType);
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

  String getMedType() {
    return _medType;
  }

  void setMedType(String medType) {
    _medType = medType;
  }

  bool getHasMedBeenTaken() {
    return _hasMedBeenTaken;
  }

  void setHasMedBeenTaken(bool hasBeenTaken) {
    _hasMedBeenTaken = hasBeenTaken;
  }

}

