
import 'package:flutter/material.dart';
import 'package:lcrealtime/Conversation.dart';
import 'package:leancloud_official_plugin/leancloud_plugin.dart';
import 'Common/Global.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Global.init().then((e) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:ConversationListPage(),
      locale: Locale('zh'),
    );
  }
}

