import 'package:shared_preferences/shared_preferences.dart';

class PersistanceHandler {
  Future<String> setTokenEDP(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("persistentTokenEDP", value);
    return value;
  }

  Future<String?> getTokenEDP() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("persistentTokenEDP");
  }
}