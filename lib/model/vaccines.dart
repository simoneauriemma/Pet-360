class Vaccines {
  late String _date;
  late String _medicine;
  late String _vaccineType;
  late String _veterenaryName;
  late List<Vaccines> _listVaccines;

  Vaccines(this._date, this._medicine, this._vaccineType, this._veterenaryName);

  void addVaccines(Vaccines vaccines) {
    _listVaccines.add(vaccines);
  }

  List<Vaccines> get listVaccines => _listVaccines;

  set listVaccines(List<Vaccines> value) {
    _listVaccines = value;
  }

  String get veterenaryName => _veterenaryName;

  set veterenaryName(String value) {
    _veterenaryName = value;
  }

  String get vaccineType => _vaccineType;

  set vaccineType(String value) {
    _vaccineType = value;
  }

  String get medicine => _medicine;

  set medicine(String value) {
    _medicine = value;
  }

  String get date => _date;

  set date(String value) {
    _date = value;
  }
}
