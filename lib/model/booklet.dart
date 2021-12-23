class Booklet {
  late String _animalBirthday;
  late String _animalColor;
  late String _animalKind;
  late String _animalName;
  late String _animalSpecie;
  late String _animalVeterinaryName;

  Booklet(this._animalBirthday, this._animalColor, this._animalKind,
      this._animalName, this._animalSpecie, this._animalVeterinaryName);

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
