import 'package:flutter/material.dart';
import 'package:flutterapplc/Login.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();

   runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:ExampleApp(),
      locale: Locale('zh'),
    );
  }
}
