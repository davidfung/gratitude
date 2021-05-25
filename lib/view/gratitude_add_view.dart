import 'package:flutter/material.dart';
import 'package:gratitude/model/gratitude_model.dart';
import 'package:gratitude/provider/gratitude_provider.dart';
import 'package:provider/provider.dart';

class GratitudeAddView extends StatelessWidget {
  static const String title = 'Add Gratitude';
  final _teController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: _buildCancelButton(context),
        title: Text(title),
        actions: [
          _buildSaveButton(context),
          SizedBox(
            width: 10,
          )
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

  Widget _buildSaveButton(BuildContext context) {
    String _content;
    DateTime pickDate = ModalRoute.of(context)!.settings.arguments as DateTime;
    return IconButton(
      icon: Icon(Icons.check),
      onPressed: () {
        _content = _teController.text;
        if (_content.length > 0) {
          Provider.of<Gratitudes>(context, listen: false)
              .addItem(Gratitude(cdate: pickDate, content: _content.trim()));
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
