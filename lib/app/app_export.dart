import 'package:flutter/cupertino.dart';
import 'package:gratitude/app/app_header.dart';
import 'package:gratitude/provider/gratitude_provider.dart';
import 'package:gratitude/util/email.dart';
import 'package:gratitude/util/setting.dart';
import 'package:provider/provider.dart';

const SUBJECT = "My Gratitudes";

void export(BuildContext context) async {
  // Export the entire database by formatting it as text and send as email body.
  final content;
  Gratitudes gratitudes;
  late final recipient;

  recipient = await loadString(SETTING_EXPORT_EMAIL, defaultValue: "");

  gratitudes = Provider.of<Gratitudes>(context, listen: false);
  content = gratitudes.export();

  sendemail(
    to: [recipient],
    cc: [],
    bcc: [],
    subject: SUBJECT,
    body: content,
  );
}
