import 'package:pet360/model/new_vaccine.dart';
import 'interface_model.dart';

class TrainerModel implements InterfaceModel {
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
  String? kindAnimal;
  String? colorAnimal;
  String? veterinaryNameAnimal;

  //var lstVaccines = List.empty();

  TrainerModel({
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
  });

  //receive data from server
  factory TrainerModel.fromMap(map) {
    return TrainerModel(
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
    );
  }

  factory TrainerModel.fromJson(Map<String, dynamic> json) {
    return TrainerModel(
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
    };
  }

  @override
  getFirstName() {
    return firstName;
  }

  @override
  getCityName() {
    return cityName;
  }

  @override
  getSurnameName() {
    return surnameName;
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

/*addVaccine(NewVaccine vaccine){
    lstVaccines.add(vaccine);
  }

  removeVaccine(NewVaccine vaccine){
    lstVaccines.remove(vaccine);
  }

  getVaccines(){
    return lstVaccines;
  }*/

}
