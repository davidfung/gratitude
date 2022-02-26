import 'package:flutter/material.dart';

const String APP_TITLE = "Gratitude";

// icon name should match the material icon counterpart for easy reference
const int icon_add_alert = 1;
const int icon_assistant_photo = 2;
const int icon_attach_file = 3;
const int icon_call = 4;
const int icon_directions_bike = 5;
const int icon_directions_walk = 6;
const int icon_favorite = 7;
const int icon_favorite_outline = 8;
const int icon_people = 9;
const int icon_portrait = 10;
const int icon_push_pin = 11;

const Map<int, Icon> GIconSet = {
  icon_add_alert: Icon(Icons.add_alert),
  icon_assistant_photo: Icon(Icons.assistant_photo),
  icon_attach_file: Icon(Icons.attach_file),
  icon_call: Icon(Icons.call),
  icon_directions_bike: Icon(Icons.directions_bike),
  icon_directions_walk: Icon(Icons.directions_walk),
  icon_favorite: Icon(Icons.favorite),
  icon_favorite_outline: Icon(Icons.favorite_outline),
  icon_people: Icon(Icons.people),
  icon_portrait: Icon(Icons.portrait),
  icon_push_pin: Icon(Icons.push_pin),
};

const String ROUTE_APP_ABOUT = '/about';
const String ROUTE_APP_SETTING = '/setting';
const String ROUTE_GRATITUDE_ADD = '/add';
const String ROUTE_GRATITUDE_EDIT = '/edit';

const String aboutUrl = 'https://amg99.com';

const TextStyle captionStyle =
    TextStyle(fontWeight: FontWeight.bold, fontSize: 18);
const TextStyle bodyStyle = TextStyle(fontSize: 16);
const TextStyle linkStyle = TextStyle(fontSize: 18, color: Colors.blue);

const String SETTING_EXPORT_EMAIL = 'export_email';
