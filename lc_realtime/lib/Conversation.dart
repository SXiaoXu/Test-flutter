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
        message.text = '一条非常重要的消息。';
        await conversation.send(message: message, receipt: true);
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
    }){
      print('lastReadAt-----onMessageRead：' + conversation.lastReadAt.toString());
    };
    jerry.onMessage = ({
      Client client,
      Conversation conversation,
      Message message,
    }) {
        print('收到的消息是：${message.stringContent}');
        print('lastReadAtlastReadAtlastReadAtlastReadAt---->：${conversation.lastReadAt.toString()}');
    };
    jerry.onLastReadAtUpdated = ({
      Client client,
      Conversation conversation,
    }){
      print('lastReadAt---onLastReadAtUpdated' + conversation.lastReadAt.toString());
    };

    jerry.onLastDeliveredAtUpdated = ({
      Client client,
      Conversation conversation,
    })async {
      print('444.lastReadAt' + conversation.lastReadAt.toString());
    };
    jerry.onMessageDelivered = ({
      Client client,
      Conversation conversation,
      String messageID,
      String toClientID,
      DateTime atDate,
    })async {
      print('messageID.messageID.messageID' + conversation.id.toString());
    };

  }


  Future Tom() async {
    Client Tom = Client(id: 'Tom');
    await Tom.open();
    Tom.onUnreadMessageCountUpdated = ({
      Client client,
      Conversation conversation,
    }) async {
      print('bbb.unreadMessageCount' + conversation.unreadMessageCount.toString());

      await conversation.read();
      print('666.unreadMessageCount' + conversation.unreadMessageCount.toString());
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
            Tom();
          },
        ),
        body: new Center(child: FlatButton(
          child: Text("normal"),
          onPressed: () {fetchData();},
        )),
      ),
    );
  }
}
