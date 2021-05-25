import 'package:shared_preferences/shared_preferences.dart';

Future<void> initSettings() async {
  // Call this function before runApp() to initialize the app with default settings.
  // if (!prefs.containsKey("StringSetting")) {
  //   await prefs.setString("StringSetting", "default"); }
  // if (!prefs.containsKey("BooleanSetting")) {
  //   await prefs.setBool("BooleanSetting", true);
  // }
  SharedPreferences prefs = await SharedPreferences.getInstance();
}
