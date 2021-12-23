import 'interface_model.dart';

class VeterinaryModel implements InterfaceModel {
  String? uid;
  String? email;
  String? firstName;
  String? surnameName;
  String? cityName;
  String? numberPhone;
  String? nameShop;
  String? cityShop;
  String? addressShop;
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

  VeterinaryModel({
    this.uid,
    this.email,
    this.firstName,
    this.surnameName,
    this.cityName,
    this.typeOfUser,
    this.numberPhone,
    this.addressShop,
    this.cityShop,
    this.nameShop,
    this.address,
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

  factory VeterinaryModel.fromJson(Map<String, dynamic> json) {
    return VeterinaryModel(
      addressShop: json['addressShop'],
      cityName: json['cityName'],
      cityShop: json['cityShop'],
      firstName: json['firstName'],
      nameShop: json['nameShop'],
      numberPhone: json['numberPhone'],
      surnameName: json['surnameName'],
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

  //receive data from server
  factory VeterinaryModel.fromMap(map) {
    return VeterinaryModel(
      uid: map['uid'],
      email: map['email'],
      firstName: map['name'],
      surnameName: map['surname'],
      cityName: map['city'],
      typeOfUser: map['typeOfUser'],
      numberPhone: map['numberPhone'],
      addressShop: map['addressShop'],
      cityShop: map['cityShop'],
      nameShop: map['nameShop'],
      address: map['address'],
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

  //sending data to server

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': firstName,
      'surname': surnameName,
      'city': cityName,
      'typeOfUser': typeOfUser,
      'numberPhone': numberPhone,
      'addressShop': addressShop,
      'cityShop': cityShop,
      'nameShop': nameShop,
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
    return numberPhone;
  }

  @override
  getAddressShop() {
    return addressShop;
  }

  @override
  getCityShop() {
    return cityShop;
  }

  @override
  getNameShop() {
    return nameShop;
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
