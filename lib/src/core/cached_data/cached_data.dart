import 'package:shared_preferences/shared_preferences.dart';

class CacheData {
  Future<SharedPreferences> createObject() async {
    return await SharedPreferences.getInstance();
  }

  Future<bool> setString({required String key, required dynamic value}) async {
    SharedPreferences prefs = await createObject();
    return await prefs.setString(key, value);
  }

  Future<bool> setBool({required String key, required dynamic value}) async {
    SharedPreferences prefs = await createObject();
    return await prefs.setBool(key, value);
  }

  Future<int?> getInt({required String key}) async {
    SharedPreferences prefs = await createObject();
    return prefs.getInt(key);
  }

  Future<bool?> getBool({required String key}) async {
    SharedPreferences prefs = await createObject();
    return prefs.getBool(key);
  }

  Future<String?> getString({required String key}) async {
    SharedPreferences prefs = await createObject();
    return prefs.getString(key);
  }
}
