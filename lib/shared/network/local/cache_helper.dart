import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? sharedPreferences;

//*Initaition
  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

//*Put data
  static Future<bool> putBoolean({
    required String key,
    required bool value,
  }) async {
    return await sharedPreferences!.setBool(key, value);
  }

  //*get data
  static bool? getBoolean({
    required String? key,
  }) {
    return sharedPreferences!.getBool(key!);
  }
}
