import 'package:flutter/material.dart';
import 'package:gratitude/app/app_header.dart';
import 'package:gratitude/app/app_about_view.dart';
import 'package:gratitude/app/app_home_view.dart';
import 'package:gratitude/app/app_setting_view.dart';
import 'package:gratitude/view/gratitude_add_view.dart';
import 'package:gratitude/view/gratitude_edit_view.dart';

final Map<String, WidgetBuilder> routesMap = {
  '/': (context) => HomeView(),
  ROUTE_APP_ABOUT: (context) => AboutView(),
  ROUTE_APP_SETTING: (context) => SettingView(),
  ROUTE_GRATITUDE_ADD: (context) => GratitudeAddView(),
  ROUTE_GRATITUDE_EDIT: (context) => GratitudeEditView(),
};
