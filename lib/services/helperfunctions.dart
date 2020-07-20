import 'package:shared_preferences/shared_preferences.dart';

class HelperFunction {
  static String sharedPrefencesUserLoggedInKey = 'IsLOGGEDIN';
  static String sharedPrefencesUserNameKey = 'USERNAMEKEY';
  static String sharedPrefencesUserEmailKey = 'USEREMAILKEY';

  //saving data in a shared preferences

  static Future<bool> saveuserLoggedInStatus(bool isUserLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(sharedPrefencesUserLoggedInKey, isUserLoggedIn);
  }

  static Future<bool> saveUserNamePrefence(String userName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPrefencesUserNameKey, userName);
  }

  static Future<bool> saveUserEmailSharedPrefences(String userEmail) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPrefencesUserEmailKey, userEmail);
  }

  //getting data from SharedPrefernce

  static Future<bool> getuserLoggedInStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(sharedPrefencesUserLoggedInKey);
  }

  static Future<String> getUserNamePrefence() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(sharedPrefencesUserNameKey);
  }

  static Future<String> getUserEmailSharedPrefences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(sharedPrefencesUserEmailKey);
  }


}
