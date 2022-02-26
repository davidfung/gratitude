import '../app/app_header.dart';

class Gratitude {
  int? id;
  DateTime? cdate;
  String? content;
  int? icon;
  int? type;
  int? favorite;
  String? hashtag;

  Gratitude(
      {this.id,
      this.cdate,
      this.content,
      this.icon,
      this.type,
      this.favorite,
      this.hashtag}) {
    if (null == this.cdate) {
      this.cdate = DateTime.now();
    }
    if (null == this.content) {
      this.content = "";
    }
    if (null == this.icon) {
      this.icon = getIcon();
    }
    if (null == this.type) {
      this.type = 0;
    }
    if (null == this.favorite) {
      this.favorite = 0;
    }
    if (null == this.hashtag) {
      this.hashtag = "";
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'cdate': cdate!.toIso8601String(),
      'content': content,
      'icon': icon,
      'type': type,
      'favorite': favorite,
      'hashtag': hashtag,
    };
  }

  //TODO: add intelligence to this routine to return an icon relevant to the
  //the task description. (Right now it always return the push pin icon.)
  int getIcon() {
    return icon_push_pin;
  }
}
