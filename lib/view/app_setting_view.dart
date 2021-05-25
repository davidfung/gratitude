import 'package:flutter/material.dart';

class SettingView extends StatelessWidget {
  static const String title = 'Settings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Container(
        color: Colors.teal,
        child: Center(child: Text(title)),
      ),
    );
  }
}
