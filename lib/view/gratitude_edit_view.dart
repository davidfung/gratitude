import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/gratitude_provider.dart';

class GratitudeEditView extends StatelessWidget {
  static const String title = "Edit Gratitude";
  final _teController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final int index = ModalRoute.of(context)!.settings.arguments as int;
    _teController.text = Provider.of<Gratitudes>(context).items[index].content!;

    return Scaffold(
      appBar: AppBar(
        leading: _buildCancelButton(context),
        title: Text(title),
        actions: <Widget>[
          _buildSaveButton(context, index),
          SizedBox(width: 10)
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        child: Column(
          children: <Widget>[
            TextField(
              autofocus: true,
              keyboardType: TextInputType.multiline,
              maxLines: 10,
              controller: _teController,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSaveButton(BuildContext context, int index) {
    String _content;
    return IconButton(
      icon: Icon(Icons.check),
      onPressed: () {
        _content = _teController.text;
        if (_content.length > 0) {
          Provider.of<Gratitudes>(context, listen: false)
              .editItem(index, _content.trim());
        }
        Navigator.pop(context);
      },
    );
  }

  Widget _buildCancelButton(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.close),
      onPressed: () => {Navigator.pop(context)},
    );
  }
}
