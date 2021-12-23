class Passport {
  late String _animalDateMicrochip;
  late String _animalDescription;
  late String _animalMicrochip;
  late String _animalIssuingAnimal;

  Passport(this._animalDateMicrochip, this._animalDescription,
      this._animalMicrochip, this._animalIssuingAnimal);

  String get animalIssuingAnimal => _animalIssuingAnimal;

  set animalIssuingAnimal(String value) {
    _animalIssuingAnimal = value;
  }

  String get animalMicrochip => _animalMicrochip;

  set animalMicrochip(String value) {
    _animalMicrochip = value;
  }

  String get animalDescription => _animalDescription;

  set animalDescription(String value) {
    _animalDescription = value;
  }

  String get animalDateMicrochip => _animalDateMicrochip;

  set animalDateMicrochip(String value) {
    _animalDateMicrochip = value;
  }
}
