import 'package:flutter/material.dart';
import 'package:gratitude/app_header.dart';
import 'package:gratitude/widget/app_drawer.dart';
import 'package:gratitude/widget/gratitude_widget.dart';

class HomeView extends StatelessWidget {
  static const String title = APP_TITLE;

  Future<DateTime> _selectDate(BuildContext context) async {
    DateTime? picked;
    picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked == null) {
      picked = DateTime.now();
    }
    return picked;
  }

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
          var picked = await _selectDate(context);
          Navigator.pushNamed(context, ROUTE_GRATITUDE_ADD, arguments: picked);
        },
        tooltip: 'Add Gratitude',
        child: const Icon(Icons.add),
      ),
    );
  }
}
