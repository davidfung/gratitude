import 'package:flutter/material.dart';
import 'package:gratitude/app/app_header.dart';
import 'package:gratitude/app/app_drawer.dart';
import 'package:gratitude/widget/gratitude_widget.dart';
import 'package:gratitude/util/utility.dart';

class HomeView extends StatelessWidget {
  static const String title = APP_TITLE;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(title),
      ),
      drawer: MainDrawer(),
      body: GratitudeListWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var picked = await selectDate(context);
          Navigator.pushNamed(context, ROUTE_GRATITUDE_ADD, arguments: picked);
        },
        tooltip: 'Add Gratitude',
        child: const Icon(Icons.add),
      ),
    );
  }
}
