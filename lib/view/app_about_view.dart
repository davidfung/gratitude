import 'package:flutter/material.dart';

class AboutView extends StatelessWidget {
  static const String title = 'About';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Container(
        color: Colors.yellow,
        child: Center(child: Text(title)),
      ),
    );
  }
}
