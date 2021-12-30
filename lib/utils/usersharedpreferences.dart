import 'package:shared_preferences/shared_preferences.dart';

class UserSharedPreferences {
  static const _typeOfUser = 'typeOfUser';
  static late final SharedPreferences? _preferences;
  static const _nameChat = 'nameChat';

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

}
