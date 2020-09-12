import 'dart:convert';

import 'package:aman_app/model/chatsdialogmodel.dart';
/**
 * Author: Damodar Lohani
 * profile: https://github.com/lohanidamodar
 */
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'ChatUI.dart';

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
  List<chatsdialogmodel> reversedList = [];
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
    return WillPopScope(
      onWillPop: callmethod(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Chat"),
          backgroundColor: Colors.blueGrey.shade900,
        ),
        body: Stack(
          children: <Widget>[
            Image.asset(
              "assets/images/backgroundchat.jpeg",
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
            check? Center(
              child: SpinKitSquareCircle(
                color: Colors.blueGrey.shade900,
                size: 50.0,
              ),
            ):Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                  Expanded(
                  child: ListView.separated(
                    reverse: true,
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 10.0);
                    },
                    itemCount: reversedList.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (reversedList[index].user1Email == getid) return _buildMessageRow(reversedList[index].dialogId, current: true);
                      return _buildMessageRow(reversedList[index].dialogId, current: false);
                      //masla kya aa raha ha??
                    },
                  ),
                ),
                _buildBottomBar(context),
              ],
            ),

          ],
        )
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
            color: Colors.blueGrey.shade900,
            onPressed: _save,
          )
        ],
      ),
    );
  }

  _save() async {
    if (_controller.text.isEmpty) return;
    FocusScope.of(context).requestFocus(FocusNode());
    sendmessage(_controller.text.toString());

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
        Flexible(
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 16.0,
            ),
            decoration: BoxDecoration(
                color: current ? Colors.blueGrey.shade900 : Colors.white,
                borderRadius: BorderRadius.circular(10.0)),
            child: Text(
              message,
              style: TextStyle(
                  color: current ? Colors.white : Colors.black, fontSize: 18.0),
            ),
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
      reversedList = new List.from(getchatslist.reversed);
      setState(() {
        check = false;
      });

    }


  }
  Future<void> sendmessage(String message) async {
    reversedList.insert(0, chatsdialogmodel.a1(message,getid,get));
    _controller.text = '';
    final ore = await SharedPreferences.getInstance();
    getid = ore.getString('id');
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Basic ' + ore.getString('counter'),
    };
    int getin = int.parse(get);
    int getin2 = int.parse(getid);
    var params = {
      "dialogId":-1,
      "messageType":1,
      "text":message,
      "mediaUrl":null,
      "fileName":null,
      "receiverId":getin,
      "senderId":getin2,
      "time":null,
      "status":null,
      "createdAt":null,
      "updatedAt":null,
    };

    Uri uri = Uri.parse("http://sarosh-001-site1.itempurl.com/api/messages/");


    var response = await http.post(uri, headers:requestHeaders, body: json.encode(params));

    if (response.statusCode == 401){
      print('error');
    }
    else if(response.statusCode == 201){
      setState(() {
        reversedList.insert(0, chatsdialogmodel.a1(message,getid,get));
        _controller.text = '';
      });

    }
  }

  callmethod() {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ChatUi()),
    );
  }
}

class Message {
  final int user;
  final String description;

  Message(this.user, this.description);
}
