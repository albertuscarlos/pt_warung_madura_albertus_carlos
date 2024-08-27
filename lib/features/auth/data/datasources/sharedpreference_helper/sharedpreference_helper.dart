import 'package:shared_preferences/shared_preferences.dart';

class AuthSharedPreferenceHelper {
  Future<SharedPreferences> sharedPreference;

  AuthSharedPreferenceHelper({
    required this.sharedPreference,
  });

  final String tokenKey = 'token';

  //Set Method
  Future<void> setToken(String tokenValue) async {
    final preference = await sharedPreference;
    preference.setString(tokenKey, tokenValue);
  }

  //Get Method
  Future<String?> get getToken async {
    final preference = await sharedPreference;
    return preference.getString(tokenKey);
  }

  //Remove Method
  Future<void> removeToken() async {
    final preference = await sharedPreference;
    preference.remove(tokenKey);
  }
}
