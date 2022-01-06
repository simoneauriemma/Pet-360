class Booklet {
  late String _animalBirthday;
  late String _animalColor;
  late String _animalKind;
  late String _animalName;
  late String _animalSpecie;
  late String _animalVeterinaryName;
  late String _animalSesso;
  late String _animalSoprannome;

  Booklet(this._animalBirthday, this._animalColor, this._animalKind,
      this._animalName, this._animalSpecie, this._animalVeterinaryName,this._animalSesso,this._animalSoprannome);

  String get animalSoprannome => _animalSoprannome;

  set animalSoprannome(String value) {
    _animalSoprannome = value;
  }

  String get animalSesso => _animalSesso;

  set animalSesso(String value) {
    _animalSesso = value;
  }

  String get animalVeterinaryName => _animalVeterinaryName;

  set animalVeterinaryName(String value) {
    _animalVeterinaryName = value;
  }

  String get animalSpecie => _animalSpecie;

  set animalSpecie(String value) {
    _animalSpecie = value;
  }

  String get animalName => _animalName;

  set animalName(String value) {
    _animalName = value;
  }

  String get animalKind => _animalKind;

  set animalKind(String value) {
    _animalKind = value;
  }

  String get animalColor => _animalColor;

  set animalColor(String value) {
    _animalColor = value;
  }

  String get animalBirthday => _animalBirthday;

  set animalBirthday(String value) {
    _animalBirthday = value;
  }
}
