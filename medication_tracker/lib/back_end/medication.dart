class Medication{

  String _name;
  String _dosage;

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

}

