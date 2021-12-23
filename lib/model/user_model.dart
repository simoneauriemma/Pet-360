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
  String? descriptionAnimal;
  String? microchipAnimal;
  String? dateMicrochipAnimal;
  String? entityIssuingAnimal;
  String? airTag1;
  String? airTag2;

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
    this.airTag1,
    this.airTag2,
    this.dateMicrochipAnimal,
    this.descriptionAnimal,
    this.entityIssuingAnimal,
    this.microchipAnimal,
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
      airTag1: map['airTag1'],
      airTag2: map['airTag2'],
      descriptionAnimal: map['descriptionAnimal'],
      dateMicrochipAnimal: map['dateMicrochipAnimal'],
      entityIssuingAnimal: map['entityIssuingAnimal'],
      microchipAnimal: map['microchipAnimal'],
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
      airTag1: json['airTag1'],
      airTag2: json['airTag2'],
      descriptionAnimal: json['descriptionAnimal'],
      dateMicrochipAnimal: json['dateMicrochipAnimal'],
      entityIssuingAnimal: json['entityIssuingAnimal'],
      microchipAnimal: json['microchipAnimal'],
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
      'airTag1': airTag1,
      'airTag2': airTag2,
      'descriptionAnimal': descriptionAnimal,
      'dateMicrochipAnimal': dateMicrochipAnimal,
      'entityIssuingAnimal': entityIssuingAnimal,
      'microchipAnimal': microchipAnimal,
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

  @override
  getAirTag1() {
    return airTag1;
  }

  @override
  getAirTag2() {
    return airTag2;
  }

  @override
  getAnimalDescription() {
    return descriptionAnimal;
  }

  @override
  getAnimalMicrochip() {
    return microchipAnimal;
  }

  @override
  getDateMicrochip() {
    return dateMicrochipAnimal;
  }

  @override
  getEntityIssuingAnimal() {
    return entityIssuingAnimal;
  }

  @override
  getPathImg() {
    // TODO: implement getPathImg
    throw UnimplementedError();
  }
}
