import 'package:shared_preferences/shared_preferences.dart';

class DataKeeped {
  Future<void> saveToken(String chave, String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(chave, token);
  }
}
