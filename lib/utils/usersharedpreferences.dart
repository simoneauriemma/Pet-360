import 'package:shared_preferences/shared_preferences.dart';

class UserSharedPreferences {
  static const _typeOfUser = 'typeOfUser';
  static late final SharedPreferences? _preferences;
  static const _nameChat = 'nameChat';
  static const _nameOfUser = 'nameOfUser';
  static const _animalName = 'animalName';

  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
    //setTypeOfUser("");
  }

  static Future setTypeOfUser(String typeOfUser) async =>
      await _preferences!.setString(_typeOfUser, typeOfUser);

  static String? getTypeOfUser() => _preferences!.getString(_typeOfUser);

  static Future setNameChat(String nameChat) async =>
      await _preferences!.setString(_nameChat, nameChat);

  static String? getNameChat() => _preferences!.getString(_nameChat);

  static Future setNameOfUser(String nameOfUser) async =>
      await _preferences!.setString(_nameOfUser, nameOfUser);

  static String? getNameOfUser() => _preferences!.getString(_nameOfUser);

  static Future setAnimalName(String animalName) async =>
      await _preferences!.setString(_animalName, animalName);

  static String? getAnimalName() => _preferences!.getString(_animalName);

}
