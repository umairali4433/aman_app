import 'dart:convert';

import 'package:aman_app/model/chatsdialogmodel.dart';
/**
 * Author: Damodar Lohani
 * profile: https://github.com/lohanidamodar
 */
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ChatTwoPage extends StatefulWidget {
  var get  = '';
  ChatTwoPage(this.get);

  static final String path = "lib/src/pages/misc/chat2.dart";
  @override
  _ChatTwoPageState createState() => _ChatTwoPageState(get);
}

//asdadasdasd
class _ChatTwoPageState extends State<ChatTwoPage> {
  var get = '';
  _ChatTwoPageState(this.get);

  List<chatsdialogmodel> getchatslist = [];
  var getid = '';
  var check = true;
  String text;
  TextEditingController _controller;
  final List<Message> messages = [
    Message(0, "But I may not go if the weather is bad."),
    Message(0, "I suppose I am."),
    Message(1, "Are you going to market today?"),
    Message(0, "I am good too"),
    Message(1, "I am fine, thank you. How are you?"),
    Message(1, "Hi,"),
    Message(0, "How are you today?"),
    Message(0, "Hello,"),
  ];
  final rand = Random();

  @override
  void initState() {
    super.initState();
    getchats();
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat"),
      ),
      body: Column(
        children: <Widget>[
          check? Text('wait'):  Expanded(
            child: ListView.separated(
              physics: BouncingScrollPhysics(),
              separatorBuilder: (context, index) {
                return const SizedBox(height: 10.0);
              },
              reverse: true,
              itemCount: getchatslist.length,
              itemBuilder: (BuildContext context, int index) {
                if (getchatslist[index].user1Email == '1398') return _buildMessageRow(getchatslist[index].dialogId, current: true);
                return _buildMessageRow(getchatslist[index].dialogId, current: false);
              },
            ),
          ),
          _buildBottomBar(context),
        ],
      ),
    );
  }
  Container _buildBottomBar(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 16.0,
      ),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(30.0),
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 20.0,
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              textInputAction: TextInputAction.send,
              controller: _controller,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 20.0,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  hintText: "Aa"),
              onEditingComplete: _save,
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            color: Theme.of(context).primaryColor,
            onPressed: _save,
          )
        ],
      ),
    );
  }

  _save() async {
    if (_controller.text.isEmpty) return;
    FocusScope.of(context).requestFocus(FocusNode());
    setState(() {
      messages.insert(0, Message(rand.nextInt(2), _controller.text));
      _controller.clear();
    });
  }

  Row _buildMessageRow(String message, {bool current}) {
    return Row(
      mainAxisAlignment:
      current ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment:
      current ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(width: current ? 30.0 : 20.0),
        if (!current) ...[

          const SizedBox(width: 5.0),
        ],
        Container(
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 16.0,
          ),
          decoration: BoxDecoration(
              color: current ? Theme.of(context).primaryColor : Colors.white,
              borderRadius: BorderRadius.circular(10.0)),
          child: Text(
            message,
            style: TextStyle(
                color: current ? Colors.white : Colors.black, fontSize: 18.0),
          ),
        ),
        if (current) ...[
          const SizedBox(width: 5.0),

        ],
        SizedBox(width: current ? 20.0 : 30.0),
      ],
    );
  }

  void getchats() async {
    final ore = await SharedPreferences.getInstance();
    getid = ore.getString('id');
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Basic ' + ore.getString('counter'),
    };
    var params = {
      "userid1": getid,
      "userid2": get
    };


    Uri uri = Uri.parse("http://sarosh-001-site1.itempurl.com/api/messages/imessage");

    final newURI = uri.replace(queryParameters: params);

    var response = await http.post(newURI, headers:requestHeaders, body: json.encode(params));

    if (response.statusCode == 401){
      print('error');
    }
    else if(response.statusCode == 200){
      var responseJson = json.decode(response.body);
      for (var u in responseJson) {
        chatsdialogmodel post = chatsdialogmodel.a1(
            u['text'].toString(), u['senderId'].toString(), u['receiverId'].toString());
        getchatslist.add(post);
      }
      print(getchatslist);
      setState(() {
        check = false;
      });

    }

  }
}

class Message {
  final int user;
  final String description;

  Message(this.user, this.description);
}
