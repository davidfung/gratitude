import 'package:gratitude/util/email.dart';

void exportData() {
  // Export the entire database by formatting it as text and send as email body.
  print("exportData()...");
  sendemail(
    to: ['davidfung@amgcomputing.com'],
    cc: [],
    bcc: [],
    subject: "My Gratitudes",
    body: "PUT DATA HERE",
  );
}
