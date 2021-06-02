// Require package: flutter_email_sender

import 'package:flutter_email_sender/flutter_email_sender.dart';

Future<void> sendemail(
    {required List<String> to,
    String subject = "",
    String body = "",
    required List<String> cc,
    required List<String> bcc,
    List<String>? attachmentPaths,
    bool isHTML = false}) async {
  final Email email = Email(
    recipients: to,
    cc: cc,
    bcc: bcc,
    subject: subject,
    body: body,
    attachmentPaths: attachmentPaths,
    isHTML: isHTML,
  );
  await FlutterEmailSender.send(email);
}
