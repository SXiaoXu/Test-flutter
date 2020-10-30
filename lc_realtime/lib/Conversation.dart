import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:leancloud_official_plugin/leancloud_plugin.dart';
import 'package:flutter/services.dart' show rootBundle;

class ConversationListPage extends StatefulWidget {
  @override
  _ConversationListPageState createState() => new _ConversationListPageState();
}

class _ConversationListPageState extends State<ConversationListPage> {
  Client jerry;
  TextMessage textMessage;
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<List> fetchData() async {
    Client jerry = Client(id: 'jerry');
// Tom 登录
 await jerry.open();
//根据 ID 查询
//    ConversationQuery query = jerry.conversationQuery();
//    query.whereEqualTo('objectId', '5ea69e7e90aef5aa8425832c');
//    List<Conversation> conversations = await query.find();
//    Conversation conversationFirst = conversations.first;
//    await conversationFirst.updateInfo(attributes: {
//      'name': '聪明的喵星人999',
//    });
//    return conversations;
    try {
      // 创建与 Jerry 之间的对话
      Conversation conversation = await jerry.createConversation(
          isUnique: true, members: {'Jerry22'}, name: 'Jerry22和Jerry');
      try {
        ByteData imageData = await rootBundle.load('assets/test.jpg');
        ImageMessage newMessage = ImageMessage.from(
          binaryData: imageData.buffer.asUint8List(),
          format: 'jpg',
          name: 'test.jpg',
        );

//        6.5.12版本中就是空的值
        print('newMessage.width------->:'+newMessage.width.toString());
        print('newMessage.height------->:'+newMessage.height.toString());

        try {
          conversation.send(message: newMessage);
        } catch (e) {
          print(e);
        }

//
//        textMessage = TextMessage();
//        textMessage.text = '起床了ma';
//        await conversation.send(message: textMessage);
      } catch (e) {
        print(e);
      }
    } catch (e) {
      print('创建会话失败:$e');
    }
  }

  Future queryConversation() async {
    List conversations;
    ConversationQuery query = jerry.conversationQuery();
    query.whereEqualTo('objectId', '5ea69e7e90aef5aa8425832c');
    conversations = await query.find();
    Conversation conversationFirst = conversations.first;
    print('name--->' + conversationFirst.name);
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Fetch Data Example',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Fetch Data Example'),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            queryConversation();
          },
        ),
        body: new Center(
          child: new Text('textMessage.ID =')
        ),
      ),
    );
  }
}
