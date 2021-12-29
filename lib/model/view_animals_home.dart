import 'package:pet360/model/interface_model.dart';

class ViewAnimalsHome implements InterfaceModel {
  String? animalName;
  String? pathImg;
  List<ViewAnimalsHome> animalsList = [];

  ViewAnimalsHome({this.animalName, this.pathImg});

  factory ViewAnimalsHome.fromJson(Map<String, dynamic> json) {
    return ViewAnimalsHome(animalName: json.keys.first, pathImg: "");
  }

  factory ViewAnimalsHome.fromMap(map) {
    return ViewAnimalsHome(animalName: map['name'], pathImg: map['pathImg']);
  }

  Map<String, dynamic> toMap() {
    return {'name': animalName, 'pathImg': pathImg};
  }

  @override
  getAnimalName() {
    return animalName;
  }

  @override
  getPathImg() {
    return pathImg;
  }

  @override
  getAddressShop() {
    // TODO: implement getAddressShop
    throw UnimplementedError();
  }

  @override
  getAirTag1() {
    // TODO: implement getAirTag1
    throw UnimplementedError();
  }

  @override
  getAirTag2() {
    // TODO: implement getAirTag2
    throw UnimplementedError();
  }

  @override
  getAnimalBirthday() {
    // TODO: implement getAnimalBirthday
    throw UnimplementedError();
  }

  @override
  getAnimalColor() {
    // TODO: implement getAnimalColor
    throw UnimplementedError();
  }

  @override
  getAnimalDescription() {
    // TODO: implement getAnimalDescription
    throw UnimplementedError();
  }

  @override
  getAnimalKind() {
    // TODO: implement getAnimalKind
    throw UnimplementedError();
  }

  @override
  getAnimalMicrochip() {
    // TODO: implement getAnimalMicrochip
    throw UnimplementedError();
  }

  @override
  getAnimalSpecie() {
    // TODO: implement getAnimalSpecie
    throw UnimplementedError();
  }

  @override
  getAnimalVeterinaryName() {
    // TODO: implement getAnimalVeterinaryName
    throw UnimplementedError();
  }

  @override
  getCityName() {
    // TODO: implement getCityName
    throw UnimplementedError();
  }

  @override
  getCityShop() {
    // TODO: implement getCityShop
    throw UnimplementedError();
  }

  @override
  getDateMicrochip() {
    // TODO: implement getDateMicrochip
    throw UnimplementedError();
  }

  @override
  getEntityIssuingAnimal() {
    // TODO: implement getEntityIssuingAnimal
    throw UnimplementedError();
  }

  @override
  getFirstName() {
    // TODO: implement getFirstName
    throw UnimplementedError();
  }

  @override
  getNameShop() {
    // TODO: implement getNameShop
    throw UnimplementedError();
  }

  @override
  getPhoneNumber() {
    // TODO: implement getPhoneNumber
    throw UnimplementedError();
  }

  @override
  getSurnameName() {
    // TODO: implement getSurnameName
    throw UnimplementedError();
  }

  @override
  getPhoto() {
    // TODO: implement getPhoto
    throw UnimplementedError();
  }
}
