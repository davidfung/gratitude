import 'package:flutter/material.dart';
import 'package:gratitude/app/app_header.dart';
import 'package:gratitude/provider/gratitude_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class GratitudeListWidget extends StatefulWidget {
  @override
  _GratitudeListWidgetState createState() => _GratitudeListWidgetState();
}

class _GratitudeListWidgetState extends State<GratitudeListWidget> {
  @override
  Widget build(BuildContext context) {
    final gratitudes = Provider.of<Gratitudes>(context);
    return ListView.builder(
      itemCount: gratitudes.items.length,
      itemBuilder: (context, index) {
        return Dismissible(
          key: UniqueKey(),
          onDismissed: (direction) {
            gratitudes.removeItem(index);
          },
          background: Container(
              alignment: AlignmentDirectional.centerStart,
              color: Colors.red,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Icon(Icons.cancel, color: Colors.white),
              )),
          child: GratitudeWidget.fromItemIndex(gratitudes, index),
          secondaryBackground: Container(
              alignment: AlignmentDirectional.centerEnd,
              color: Colors.red,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 30, 0),
                child: Icon(Icons.cancel, color: Colors.white),
              )),
        );
      },
    );
  }
}

class GratitudeWidget extends StatelessWidget {
  final String title;
  final String body;
  final Icon? icon;
  final int index;

  GratitudeWidget(this.title, this.body, this.icon, this.index);

  GratitudeWidget.fromItemIndex(Gratitudes gratitudes, int index)
      : title = DateFormat("EEEE, MMMM d, yyyy")
            .format(gratitudes.items[index].cdate!),
        body = gratitudes.items[index].content!,
        icon = gratitudes.items[index].favorite == 0
            ? GIconSet[icon_favorite_outline]
            : GIconSet[icon_favorite],
        index = index;

  @override
  Widget build(BuildContext context) {
    final Text subtitle;

    if (this.body.isEmpty) {
      subtitle = Text("What are you thankful for today?",
          style: TextStyle(
              fontSize: 14.0,
              color: Colors.blueGrey,
              fontStyle: FontStyle.italic));
    } else {
      subtitle =
          Text(body, style: TextStyle(fontSize: 14.0, color: Colors.black));
    }

    return ListTile(
      leading: icon,
      title: Text(title,
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
      subtitle: subtitle,
      onTap: () {
        Navigator.pushNamed(context, ROUTE_GRATITUDE_EDIT, arguments: index);
      },
    );
  }
}
