import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'app_header.dart';
import '../util/web.dart';

class AboutView extends StatelessWidget {
  static const String title = 'About';

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: PackageInfo.fromPlatform(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              appBar: AppBar(
                title: Text(AboutView.title),
              ),
              body: ListView(
                padding: const EdgeInsets.symmetric(
                    vertical: 30.0, horizontal: 30.0),
                children: <Widget>[
                  SectionWidget(
                    sectionTitle: "GRATITUDE",
                    sectionBody: 'Your gratitude journal.',
                  ),
                  SectionWidget(
                    sectionTitle: "WHY",
                    sectionBody:
                        "Record your gratitudes day by day to see how blessed you are!",
                  ),
                  SectionWidget(
                    sectionTitle: "VERSION",
                    sectionBody: (snapshot.data as PackageInfo).version +
                        "+" +
                        (snapshot.data as PackageInfo).buildNumber,
                  ),
                  FeedbackWidget(),
                ],
              ),
            );
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}

class SectionWidget extends StatelessWidget {
  const SectionWidget({
    Key? key,
    required this.sectionTitle,
    required this.sectionBody,
  }) : super(key: key);

  final String sectionTitle;
  final String sectionBody;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(sectionTitle, style: captionStyle),
        Padding(
          padding: EdgeInsets.only(top: 7),
        ),
        Text(sectionBody, style: bodyStyle),
        Padding(
          padding: EdgeInsets.only(top: 30),
        ),
      ],
    );
  }
}

class FeedbackWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('FEEDBACK', style: captionStyle),
        Padding(
          padding: EdgeInsets.only(top: 7),
        ),
        InkWell(
            onTap: () {
              launchURL(aboutUrl);
            },
            child: Text('Visit amg99.com', style: linkStyle)),
      ],
    );
  }
}
