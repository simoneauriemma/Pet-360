class NewVaccine {
  String? vaccineType;
  String? date;
  String? medicine;
  String? veterinaryName;

  NewVaccine({
    this.vaccineType,
    this.date,
    this.medicine,
    this.veterinaryName,
  });

  //receive data from server
  factory NewVaccine.fromMap(map) {
    return NewVaccine(
      vaccineType: map['vaccineType'],
      date: map['date'],
      medicine: map['medicine'],
      veterinaryName: map['veterinaryName'],
    );
  }

  factory NewVaccine.fromJson(Map<String, dynamic> json) {
    return NewVaccine(
      vaccineType: json['vaccineType'],
      date: json['date'],
      medicine: json['medicine'],
      veterinaryName: json['veterinaryName'],
    );
  }

  //sending data to server

  Map<String, dynamic> toMap() {
    return {
      'vaccineType': vaccineType,
      'date': date,
      'medicine': medicine,
      'veterinaryName': veterinaryName,
    };
  }
}
