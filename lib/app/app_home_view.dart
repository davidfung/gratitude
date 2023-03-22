import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gratitude/app/app_header.dart';
import 'package:gratitude/app/app_drawer.dart';
import 'package:gratitude/provider/gratitude_provider.dart';
import 'package:gratitude/widget/gratitude_widget.dart';
import 'package:gratitude/util/utility.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  static const String title = APP_TITLE;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(title),
        actions: [ContentIcon(), FilterIcon()],
      ),
      drawer: MainDrawer(),
      body: GratitudeListWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var picked = await selectDate(context);
          if (picked != null) {
            Navigator.pushNamed(context, ROUTE_GRATITUDE_ADD,
                arguments: picked);
          }
        },
        tooltip: 'Add Gratitude',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class FilterIcon extends StatefulWidget {
  const FilterIcon({
    Key? key,
  }) : super(key: key);

  @override
  State<FilterIcon> createState() => _FilterIconState();
}

class _FilterIconState extends State<FilterIcon> {
  bool filterOn = false;
  @override
  Widget build(BuildContext context) {
    final Gratitudes g = Provider.of<Gratitudes>(context);
    return IconButton(
      iconSize: 20,
      icon: filterOn
          ? FaIcon(FontAwesomeIcons.filterCircleXmark)
          : FaIcon(FontAwesomeIcons.filter),
      onPressed: () {
        setState(() {
          filterOn = !filterOn;
          g.setFilterOn(filterOn);
        });
      },
    );
  }
}

class ContentIcon extends StatefulWidget {
  const ContentIcon({
    Key? key,
  }) : super(key: key);

  @override
  State<ContentIcon> createState() => _ContentIconState();
}

class _ContentIconState extends State<ContentIcon> {
  bool showContent = false;
  @override
  Widget build(BuildContext context) {
    final Gratitudes g = Provider.of<Gratitudes>(context);
    return IconButton(
      iconSize: 20,
      icon: showContent
          ? FaIcon(FontAwesomeIcons.eye)
          : FaIcon(FontAwesomeIcons.eyeSlash),
      onPressed: () {
        setState(() {
          showContent = !showContent;
          g.setShowContent(showContent);
        });
      },
    );
  }
}
