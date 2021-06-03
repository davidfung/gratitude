import 'package:flutter/material.dart';

/// Pop up an UI for user to select a date.
/// Return null if user cancels.
Future<DateTime?> selectDate(BuildContext context) async {
  DateTime? picked;
  picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(2025),
  );
  return picked;
}
