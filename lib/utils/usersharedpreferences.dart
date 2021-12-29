import 'package:shared_preferences/shared_preferences.dart';

class UserSharedPreferences {
  static const _typeOfUser = 'typeOfUser';
  static const _index = "index";
  static late final SharedPreferences? _preferences;

  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
    //setTypeOfUser("");
  }

  static Future setTypeOfUser(String typeOfUser) async =>
      await _preferences!.setString(_typeOfUser, typeOfUser);

  static String? getTypeOfUser() => _preferences!.getString(_typeOfUser);

  static Future setIndex(int index) async =>
      await _preferences!.setInt(_index, index);

  static int? getIndex() => _preferences!.getInt(_index);

}
