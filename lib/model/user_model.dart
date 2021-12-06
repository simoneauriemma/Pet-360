class UserModel {
  String? uid;
  String? email;
  String? firstName;
  String? surnameName;
  String? cityName;
  int? typeOfUser;

  UserModel(
      {this.uid,
      this.email,
      this.firstName,
      this.surnameName,
      this.cityName,
      this.typeOfUser});

  //receive data from server
  factory UserModel.fromMap(map) {
    return UserModel(
        uid: map['uid'],
        email: map['email'],
        firstName: map['name'],
        surnameName: map['surname'],
        cityName: map['city'],
        typeOfUser: map['typeOfUser']);
  }
  //sending data to server

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': firstName,
      'surname': surnameName,
      'city': cityName,
      'typeOfUser': typeOfUser
    };
  }
}