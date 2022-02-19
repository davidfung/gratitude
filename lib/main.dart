import 'package:flutter/material.dart';
import 'package:gratitude/app/app_header.dart';
import 'package:gratitude/provider/gratitude_provider.dart';
import 'package:gratitude/app/app_util.dart';
import 'package:provider/provider.dart';
import 'package:gratitude/app/app_route.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initSettings();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Gratitudes(),
      child: MaterialApp(
        title: APP_TITLE,
        theme: ThemeData(
          primaryColor: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/',
        routes: routesMap,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
