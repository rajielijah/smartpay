import 'package:shared_preferences/shared_preferences.dart';
// ignore_for_file: constant_identifier_names



const String PREFS_KEY_OTP_SETTING = "PREFS_KEY_OTP_SETTING";
const String PREFS_KEY_DEVICE_TOKEN = "PREFS_KEY_DEVICE_TOKEN";
const String PREFS_KEY_ONBOARDING_SCREEN = "PREFS_KEY_ONBOARDING_SCREEN";
const String PREFS_KEY_USER_EMAIL = "PREFS_KEY_USER_EMAIL";
const String PREFS_KEY_NEW_EMAIL = "PREFS_KEY_NEW_EMAIL";






class AppPreferences {

   final SharedPreferences _sharedPreferences;

  AppPreferences(this._sharedPreferences);

    Future<void> setUserEmail(String userEmail) async {
    _sharedPreferences.setString(PREFS_KEY_USER_EMAIL, userEmail);
  }

 Future<void> setNewEmail(String newEmail) async {
    _sharedPreferences.setString(PREFS_KEY_USER_EMAIL, newEmail);
  }
    Future<void> setOnBoardingScreenViewed() async {
    _sharedPreferences.setBool(PREFS_KEY_ONBOARDING_SCREEN, true);
  }

    bool getUserOtpSetting()  {
    return _sharedPreferences.getBool(PREFS_KEY_OTP_SETTING) ?? true;
  }

    Future<String> getdevice_name() async{
    return _sharedPreferences.getString(PREFS_KEY_DEVICE_TOKEN) ?? "frn29CE0M0Xmu00QEWiO_i:APA91bFl8ewytX60UWzm4loASQp-0wGfVDejCcKl62jShkupZQmH4Qf6LbkRl-uvh5w5cT6irSkc1uwEFsiswe2KrSqQE24-cWeY02oeisKnZ-TJuW33DsNsgaQFkdym4sofuaFST0hJ";
  }

Future<bool> isOnBoardingScreenViewed() async {
    return _sharedPreferences.getBool(PREFS_KEY_ONBOARDING_SCREEN) ?? false;
  }  
 String getUserEmail()  {
    return _sharedPreferences.getString(PREFS_KEY_USER_EMAIL) ?? "";
  }

   String getNewEmail()  {
    return _sharedPreferences.getString(PREFS_KEY_NEW_EMAIL) ?? "";
  }
}