import 'package:flutter/cupertino.dart';
import 'package:gratitude/provider/gratitude_provider.dart';
import 'package:gratitude/util/email.dart';
import 'package:provider/provider.dart';

const SUBJECT = "My Gratitudes";

void export(BuildContext context) {
  // Export the entire database by formatting it as text and send as email body.
  final content;
  Gratitudes gratitudes;

  gratitudes = Provider.of<Gratitudes>(context, listen: false);
  content = gratitudes.export();

  sendemail(
    to: [],
    cc: [],
    bcc: [],
    subject: SUBJECT,
    body: content,
  );
}
