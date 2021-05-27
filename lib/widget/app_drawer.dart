import 'package:flutter/material.dart';
import 'package:gratitude/app_header.dart';
import 'package:gratitude/export.dart';
import 'package:gratitude/view/app_about_view.dart';
import 'package:gratitude/view/app_setting_view.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          Container(
            height: 60,
            child: DrawerHeader(
                child: Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 20),
                    child: Text(APP_TITLE,
                        style: TextStyle(fontSize: 18, color: Colors.white))),
                decoration: BoxDecoration(color: Theme.of(context).accentColor),
                margin: EdgeInsets.all(0.0),
                padding: EdgeInsets.all(0.0)),
          ),
          buildListTile(AboutView.title, Icons.settings, () {
            Navigator.of(context).popAndPushNamed(ROUTE_APP_ABOUT);
          }),
          buildListTile(SettingView.title, Icons.info_outline, () {
            Navigator.of(context).popAndPushNamed(ROUTE_APP_SETTING);
          }),
          buildListTile("Export", Icons.import_export_outlined, () {
            Navigator.of(context).pop();
            export(context);
          }),
        ],
      ),
    );
  }

  Widget buildListTile(String title, IconData icon, VoidCallback tapHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 18,
        ),
      ),
      onTap: tapHandler,
    );
  }
}
