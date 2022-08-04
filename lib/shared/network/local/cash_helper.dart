import 'package:shared_preferences/shared_preferences.dart';

class CashHelper {
  static late SharedPreferences sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool?> putData({
    required String key,
    required dynamic value,
  }) async {
    if(value is String){
      return await sharedPreferences.setString(key, value);
    }
    else if(value is int){
      return await sharedPreferences.setInt(key, value);
    }
  }

  static String? getString({
  required String key,
}){
    return sharedPreferences.getString(key);
  }

  static int? getInt({
    required String key,
  }){
    return sharedPreferences.getInt(key);
  }

  static Future<bool> clearData({required String key}) async{
    return await sharedPreferences.remove(key);
  }

}
