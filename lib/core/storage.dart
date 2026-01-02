// ignore_for_file: avoid_print

import 'package:shared_preferences/shared_preferences.dart';

//....DANISH
class SharedPrefStorage {
  //DANISH
  //..............................................STORE STRING IN LOCAL STORAGE
  static storeString({required String key, required String value}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(key, value);
    print("..............................Saving DATA $key $value ");
    return true;
  }

  static storeToken({required String key, required String value}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
   await pref.setString(key, value);
    print("..............................Saving DATA $key $value ");
    // await Get.find<UserController>().checkUserLoggedIn();
    return true;
  }

  //DANISH
  //..............................................GET STRING IN LOCAL STORAGE
  static getString({required String key}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(
        "..............................Getting data DATA $key ${pref.get(key)} ");
    return pref.get(key);
  }

  //DANISH
  //..............................................GET STRING IN LOCAL STORAGE
  static getBool({required String key}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(
        "..............................Getting data DATA $key ${pref.get(key)} ");
    return pref.getBool(key);
  }

  //DANISH
  //..............................................CLEAR ALL LOCAL STORAGE
  static clearStorage() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
  }
}