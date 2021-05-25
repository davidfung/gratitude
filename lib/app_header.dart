import 'package:flutter/material.dart';

// App main color
Map<int, Color> blueColorMap = {
  50: Color.fromRGBO(0x8a, 0xbe, 0xf2, .1),
  100: Color.fromRGBO(0x8a, 0xbe, 0xf2, .2),
  200: Color.fromRGBO(0x8a, 0xbe, 0xf2, .3),
  300: Color.fromRGBO(0x8a, 0xbe, 0xf2, .4),
  400: Color.fromRGBO(0x8a, 0xbe, 0xf2, .5),
  500: Color.fromRGBO(0x8a, 0xbe, 0xf2, .6),
  600: Color.fromRGBO(0x8a, 0xbe, 0xf2, .7),
  700: Color.fromRGBO(0x8a, 0xbe, 0xf2, .8),
  800: Color.fromRGBO(0x8a, 0xbe, 0xf2, .9),
  900: Color.fromRGBO(0x8a, 0xbe, 0xf2, 1),
};

Map<int, Color> greenColorMap = {
  50: Color.fromRGBO(0xcd, 0xdb, 0x89, .1),
  100: Color.fromRGBO(0xcd, 0xdb, 0x89, .2),
  200: Color.fromRGBO(0xcd, 0xdb, 0x89, .3),
  300: Color.fromRGBO(0xcd, 0xdb, 0x89, .4),
  400: Color.fromRGBO(0xcd, 0xdb, 0x89, .5),
  500: Color.fromRGBO(0xcd, 0xdb, 0x89, .6),
  600: Color.fromRGBO(0xcd, 0xdb, 0x89, .7),
  700: Color.fromRGBO(0xcd, 0xdb, 0x89, .8),
  800: Color.fromRGBO(0xcd, 0xdb, 0x89, .9),
  900: Color.fromRGBO(0xcd, 0xdb, 0x89, 1),
};

MaterialColor appColor = MaterialColor(0xFF8abef2, blueColorMap);
MaterialColor secColor = MaterialColor(0xFFcddb89, greenColorMap);

const String APP_TITLE = "Gratitude";

// icon name should match the material icon counterpart for easy reference
const int icon_default = 0;
const int icon_add_alert = 1;
const int icon_assistant_photo = 2;
const int icon_attach_file = 3;
const int icon_call = 4;
const int icon_directions_bike = 5;
const int icon_directions_walk = 6;
const int icon_people = 7;
const int icon_portrait = 8;

const Map<int, Icon> GIconSet = {
  icon_default: Icon(Icons.add_alert),
  icon_add_alert: Icon(Icons.add_alert),
  icon_assistant_photo: Icon(Icons.assistant_photo),
  icon_attach_file: Icon(Icons.attach_file),
  icon_call: Icon(Icons.call),
  icon_directions_bike: Icon(Icons.directions_bike),
  icon_directions_walk: Icon(Icons.directions_walk),
  icon_people: Icon(Icons.people),
  icon_portrait: Icon(Icons.portrait),
};

const String ROUTE_APP_ABOUT = "/about";
const String ROUTE_APP_SETTING = "/setting";
const String ROUTE_GRATITUDE_ADD = "/add";
const String ROUTE_GRATITUDE_EDIT = "/edit";
