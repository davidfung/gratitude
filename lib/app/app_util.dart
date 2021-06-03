import 'package:shared_preferences/shared_preferences.dart';

import 'app_header.dart';

/// Call this function before runApp() to initialize the app with default settings.
Future<void> initSettings() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (!prefs.containsKey(SETTING_EXPORT_EMAIL)) {
    await prefs.setString(SETTING_EXPORT_EMAIL, '');
  }
}
