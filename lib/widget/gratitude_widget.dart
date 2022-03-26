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
  final int index;

  GratitudeWidget.fromItemIndex(Gratitudes gratitudes, int index)
      : title = DateFormat("EEEE, MMMM d, yyyy")
            .format(gratitudes.items[index].cdate!),
        body = gratitudes.items[index].content!,
        index = index;

  Widget build(BuildContext context) {
    final Text subtitle;

    if (this.body.isEmpty) {
      subtitle = Text("What are you thankful for today?",
          style: TextStyle(
              fontSize: 14.0,
              color: Colors.blueGrey,
              fontStyle: FontStyle.italic));
    } else {
      subtitle = Text(this.body,
          style: TextStyle(fontSize: 14.0, color: Colors.black));
    }

    return ListTile(
      leading: FavIcon(index: index),
      title: Text(this.title,
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
      subtitle: subtitle,
      onTap: () {
        Navigator.pushNamed(context, ROUTE_GRATITUDE_EDIT,
            arguments: this.index);
      },
    );
  }
}

class FavIcon extends StatefulWidget {
  FavIcon({
    required int index,
  }) {
    this.index = index;
  }

  late final int index;

  @override
  State<FavIcon> createState() => _FavIconState();
}

class _FavIconState extends State<FavIcon> {
  late Widget icon;

  @override
  Widget build(BuildContext context) {
    final Gratitudes g = Provider.of<Gratitudes>(context);
    if (g.items[widget.index].favorite == 1) {
      icon = Icon(
        Icons.favorite,
        color: Colors.red,
      );
    } else {
      icon = Icon(Icons.favorite_outline);
    }
    return IconButton(
        icon: icon,
        onPressed: () {
          g.toggleFavorite(g.items[widget.index].id!);
        });
  }
}
