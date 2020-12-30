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
    Client jerry = Client(id: 'Jerry');
    await jerry.open();
    try {
      // 创建与 Jerry 之间的对话
      Conversation conversation = await jerry.createConversation(
          isUnique: true, members: {'Tom'}, name: '111');
      try {
        TextMessage message = TextMessage();
        message.text = '测试一条暂态消息';
        await conversation.send(message: message, transient: true);
        await conversation.fetchReceiptTimestamps();
        print('发送成功');
      } catch (e) {
        print(e);
      }
    } catch (e) {
      print('创建会话失败:$e');
    }
    jerry.onMessageRead = ({
      Client client,
      Conversation conversation,
      String messageID,
      String byClientID,
      DateTime atDate,
    }) {
      print('--onMessageRead--：' + conversation.lastReadAt.toString());
    };
    jerry.onMessage = ({
      Client client,
      Conversation conversation,
      Message message,
    }) {
      print('收到的消息是：${message.stringContent}');
      print('--onMessage--：' + conversation.lastReadAt.toString());
    };
    jerry.onLastReadAtUpdated = ({
      Client client,
      Conversation conversation,
    }) {
      print('--onLastReadAtUpdated--：' + conversation.lastReadAt.toString());
    };

    jerry.onLastDeliveredAtUpdated = ({
      Client client,
      Conversation conversation,
    }) async {
      print(
          '--onLastDeliveredAtUpdated--：' + conversation.lastReadAt.toString());
    };
    jerry.onMessageDelivered = ({
      Client client,
      Conversation conversation,
      String messageID,
      String toClientID,
      DateTime atDate,
    }) async {
      print('--onMessageDelivered--：' + conversation.lastReadAt.toString());
    };
  }

  Future tom() async {
    print('收到的消息是');
    Client tom;
    try {
      tom = Client(id: 'Tom');
      await tom.open();
      print('open成功');
    } catch (e) {
      print('创建会话失败:$e');
    }
    tom.onUnreadMessageCountUpdated = ({
      Client client,
      Conversation conversation,
    }) async {
      print('unreadMessageCount' + conversation.unreadMessageCount.toString());
      await conversation.read();
    };
    tom.onMessage = ({
      Client client,
      Conversation conversation,
      Message message,
    }) {
      if (message is TextMessage) {
        print('消息ID：${message.id}');
        print('消息 isTransient：${message.isTransient}');
      }
    };
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
