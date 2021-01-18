import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:leancloud_official_plugin/leancloud_plugin.dart';
import 'package:flutter/services.dart' show rootBundle;

class ConversationListPage extends StatefulWidget {
  @override
  _ConversationListPageState createState() => new _ConversationListPageState();
}

class _ConversationListPageState extends State<ConversationListPage> {
  @override
  void initState() {
    super.initState();
  }

  Future<List> fetchData() async {
    //Todo
  }

  Future tom() async {
    Client tom;
    tom = Client(id: 'Tom');
    await tom.open();

    try {
      // 创建与 Jerry 之间的对话
      Conversation conversation = await tom.createConversation(
          isUnique: true, members: {'Jerry'}, name: 'Tom & Jerry');

      print('Conversation-ID = ' + conversation.id);
      try {
        TextMessage textMessage = TextMessage();
        textMessage.text = 'Jerry，起床了！';
        await conversation.send(message: textMessage);
        print('Message-ID = ' + textMessage.id);

      } catch (e) {
        print(e);
      }
    } catch (e) {
      print('创建会话失败:$e');
    }

    String convID = '5fd895b670b5c8f1c55ba968';
    ConversationQuery query = tom.conversationQuery();
    query.whereEqualTo('objectId', convID);
    query.includeLastMessage = true;

    List<Conversation> conversations = await query.find();
    assert(conversations.length == 1);
    assert(conversations[0].lastMessage != null);
    print("conversations[0].lastMessage-------" +
        conversations[0].lastMessage.toString());

    print("conversations[0].lastMessage.id-------" +
        conversations[0].lastMessage.id);
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
            tom();
          },
        ),
        body: new Center(
            child: FlatButton(
          child: Text("发送一条消息"),
          onPressed: () {
            fetchData();
          },
        )),
      ),
    );
  }
}
