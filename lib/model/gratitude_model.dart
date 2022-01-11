import '../app/app_header.dart';

class Gratitude {
  int? id;
  DateTime? cdate;
  String? content;
  int? icon;

  Gratitude({this.id, this.cdate, this.content, this.icon}) {
    if (null == this.cdate) {
      this.cdate = DateTime.now();
    }
    if (null == this.icon) {
      this.icon = getIcon();
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'cdate': cdate!.toIso8601String(),
      'content': content,
      'icon': icon,
    };
  }

  //TODO: add intelligence to this routine to return an icon relevant to the
  //the task description.
  int getIcon() {
    return icon_assistant_photo;
  }
}
