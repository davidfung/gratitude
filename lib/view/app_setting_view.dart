import 'package:flutter/material.dart';
import '../util/setting.dart';
import '../app_header.dart';

const capExportEmail = 'Export Email';

class SettingView extends StatefulWidget {
  static const String title = 'Settings';

  @override
  _SettingViewState createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  String exportEmail = "";
  bool loaded = false;

  @override
  void initState() {
    _loadSettings();
    super.initState();
  }

  Future<void> _loadSettings() async {
    this.exportEmail = await loadString(SETTING_EXPORT_EMAIL, defaultValue: "");
    loaded = true;
    setState(() {});
  }

  void _updateExportEmail(String value) {
    this.exportEmail = value;
    saveString(SETTING_EXPORT_EMAIL, value);
  }

  @override
  Widget build(BuildContext context) {
    Widget body;
    if (loaded) {
      body = _buildPage(context);
    } else {
      body = Center(
        child: CircularProgressIndicator(),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(SettingView.title),
      ),
      body: body,
    );
  }

  Widget _buildPage(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(10.0),
      children: <Widget>[
        _buildSectionHead(context, capExportEmail),
        _buildExportEmail(context),
      ],
    );
  }

  Widget _buildSectionHead(BuildContext context, String title) {
    return ListTile(
        title: Text(
      title,
      style: captionStyle,
    ));
  }

  Widget _buildExportEmail(BuildContext context) {
    final _teController = TextEditingController();
    _teController.text = this.exportEmail;

    return Column(
      children: <Widget>[
        Row(children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _teController,
                  onChanged: (value) {
                    _updateExportEmail(value);
                  }),
            ),
          ),
        ]),
      ],
    );
  }
}
