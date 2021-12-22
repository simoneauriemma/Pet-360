import 'interface_model.dart';

class UserModel implements InterfaceModel {
  String? uid;
  String? email;
  String? firstName;
  String? surnameName;
  String? cityName;
  String? address;
  String? typeOfUser;
  String? nameAnimal;
  String? birthdayAnimal;
  String? specieAnimal;
  String? colorAnimal;
  String? veterinaryNameAnimal;
  String? kindAnimal;

  UserModel({
    this.uid,
    this.email,
    this.firstName,
    this.surnameName,
    this.cityName,
    this.address,
    this.typeOfUser,
    this.nameAnimal,
    this.birthdayAnimal,
    this.specieAnimal,
    this.colorAnimal,
    this.veterinaryNameAnimal,
    this.kindAnimal,
  });

  //receive data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      firstName: map['name'],
      surnameName: map['surname'],
      cityName: map['city'],
      address: map['address'],
      typeOfUser: map['typeOfUser'],
      nameAnimal: map['nameAnimal'],
      birthdayAnimal: map['birthdayAnimal'],
      specieAnimal: map['specieAnimal'],
      colorAnimal: map['colorAnimal'],
      veterinaryNameAnimal: map['veterinaryNameAnimal'],
      kindAnimal: map['kindAnimal'],
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      firstName: json['firstName'],
      surnameName: json['surnameName'],
      cityName: json['cityName'],
      address: json['address'],
      nameAnimal: json['nameAnimal'],
      birthdayAnimal: json['birthdayAnimal'],
      specieAnimal: json['specieAnimal'],
      colorAnimal: json['colorAnimal'],
      veterinaryNameAnimal: json['veterinaryNameAnimal'],
      kindAnimal: json['kindAnimal'],
    );
  }

  //sending data to server

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': firstName,
      'surname': surnameName,
      'city': cityName,
      'typeOfUser': typeOfUser,
      'address': address,
      'nameAnimal': nameAnimal,
      'birthdayAnimal': birthdayAnimal,
      'specieAnimal': specieAnimal,
      'colorAnimal': colorAnimal,
      'veterinaryNameAnimal': veterinaryNameAnimal,
      'kindAnimal': kindAnimal,
    };
  }

  @override
  getFirstName() {
    return firstName;
  }

  @override
  getSurnameName() {
    return surnameName;
  }

  @override
  getCityName() {
    return cityName;
  }

  @override
  getPhoneNumber() {
    return null;
  }

  @override
  getAddressShop() {
    return null;
  }

  @override
  getCityShop() {
    return null;
  }

  @override
  getNameShop() {
    return null;
  }

  @override
  getAnimalBirthday() {
    return birthdayAnimal;
  }

  @override
  getAnimalName() {
    return nameAnimal;
  }

  @override
  getAnimalSpecie() {
    return specieAnimal;
  }

  @override
  getAnimalColor() {
    return colorAnimal;
  }

  @override
  getAnimalVeterinaryName() {
    return veterinaryNameAnimal;
  }

  @override
  getAnimalKind() {
    return kindAnimal;
  }
}
