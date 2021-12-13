import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:leancloud_official_plugin/leancloud_plugin.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:fluttertoast/fluttertoast.dart';

class ConversationListPage extends StatefulWidget {
  @override
  _ConversationListPageState createState() => new _ConversationListPageState();
}

class _ConversationListPageState extends State<ConversationListPage> {
  @override
  void initState() {
    super.initState();
  }

  Future<List> firstButton() async {
    toast('点击按钮');
    Client tom;
    tom = Client(id: 'Tom20210726');
    await tom.open();
    toast('OPEN 成功');
    try {
      // 创建与 Jerry 之间的对话
      Conversation conversation = await tom.createConversation(
          isUnique: true, members: {'Jerry20210726'}, name: 'Tom & Jerry');
      ByteData imageData = await rootBundle.load('assets/tupian.jpeg');
      ImageMessage imageMessage = ImageMessage.from(
        binaryData: imageData.buffer.asUint8List(),
        format: 'png',
        name: 'height.png',
      );
      try {
        conversation.send(message: imageMessage);
        print('发送图片消息成功');
        toast('发送图片消息成功');
      } catch (e) {
        print('发送消息失败:$e');
        toast('发送消息失败');
      }
    } catch (e) {
      print('创建会话失败:$e');
      toast('创建会话失败');
    }
  }

  Future secondButton() async {
    Client tom;
    tom = Client(id: 'Tom20210726');
    await tom.open();
    String convID = '60fe8442025b2228efb93933';
    try {
      ConversationQuery query = tom.conversationQuery();
      query.whereEqualTo('objectId', convID);
      List<Conversation> conversations = await query.find();
      Conversation firetCon = conversations.first;
      try {
        List<Message> messages = await firetCon.queryMessage(
          limit: 10,
        );
        messages.forEach((element) {
          if (element is ImageMessage) {
            print('图像消息，URL：${element.url}');
            toast('图像消息的 URL ${element.url}');
          }
        });
      } catch (e) {
        print(e);
      }
    } catch (e) {
      print(e);
    }
    tom.onMessage = ({
      Client client,
      Conversation conversation,
      Message message,
    }) {
      if (message is ImageMessage) {
        print('收到图像消息，URL：${message.url}');
        toast('收到图像消息，URL：${message.url}');
      }
    };
  }

  void toast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
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
            secondButton();
          },
        ),
        body: new Center(
            child: TextButton(
          child: Text('发送一条图片消息'),
          onPressed: () {
            firstButton();
          },
        )),
      ),
    );
  }
}
