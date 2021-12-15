import 'interface_model.dart';

class UserModel implements InterfaceModel {
  String? uid;
  String? email;
  String? firstName;
  String? surnameName;
  String? cityName;
  String? address;
  String? typeOfUser;

  UserModel(
      {this.uid,
      this.email,
      this.firstName,
      this.surnameName,
      this.cityName,
      this.address,
      this.typeOfUser});

  //receive data from server
  factory UserModel.fromMap(map) {
    return UserModel(
        uid: map['uid'],
        email: map['email'],
        firstName: map['name'],
        surnameName: map['surname'],
        cityName: map['city'],
        address: map['address'],
        typeOfUser: map['typeOfUser']);
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      firstName: json['firstName'],
      surnameName: json['surnameName'],
      cityName: json['cityName'],
      address: json['address'],
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
      'address': address
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
}
