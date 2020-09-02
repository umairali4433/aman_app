import 'dart:convert';

/**
 * Author: Siddhartha Joshi
 * profile: https://github.com/cimplesid
 */

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:aman_app/model/chatsdialogmodel.dart';

import 'Alluserslist.dart';

class ChatUi extends StatefulWidget {
  chatsubstate createState() => chatsubstate();
}

class chatsubstate extends State<ChatUi> with SingleTickerProviderStateMixin {
  List<chatsdialogmodel> chatdialoglist = [];
  static final String path = "lib/src/pages/misc/chatui.dart";

  var hasData = true;

  @override
  void initState() {
    getchats();
    super.initState();
  }
  ////asdasdasdsaddasdsd

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Allusers()),
          );
        },
      ),
      backgroundColor: Color(0xFF363846),
      body: hasData
          ? Center(
              child: SpinKitSquareCircle(
                color: Colors.white,
                size: 50.0,
                controller: AnimationController(
                    vsync: this, duration: const Duration(milliseconds: 1200)),
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 20.0),
                  child: Text(
                    'Chats',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF414350),
                      borderRadius: BorderRadius.circular(5.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black54,
                          offset: Offset(0.0, 1.5),
                          blurRadius: 1.0,
                          spreadRadius: -1.0,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  child: TextField(
                    decoration: InputDecoration(
                        hintText: 'Search your friends...',
                        hintStyle: TextStyle(
                          color: Colors.white54,
                        ),
                        filled: true,
                        fillColor: Color(0xFF414350),
                        suffixIcon: Icon(
                          Icons.search,
                          color: Colors.white70,
                        ),
                        border: InputBorder.none),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          chatdialoglist[index].user1Email,
                          style: TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(chatdialoglist[index].lastMessage,
                            style: TextStyle(color: Colors.white)),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://aman.paknavy.gov.pk/images/logo.png'),
                        ),
                      );
                    },
                    itemCount: chatdialoglist.length,
                  ),
                )
              ],
            ),
    );
  }

  Future<void> getchats() async {
    Codec<String, String> stringToBase64 = utf8.fuse(base64);

    String encoded = stringToBase64.encode('wahid@wahid.com 123');

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Basic ' + encoded,
    };

    final response = await http.get(
      'http://sarosh-001-site1.itempurl.com/api/dialogs/1398',
      headers: requestHeaders,
    );

    if (response.statusCode == 401) {
      print("you are not authorized user");
    } else if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);

      for (var u in responseJson) {
        chatsdialogmodel post = chatsdialogmodel(
            u['dialogId'].toString(),
            u['user1Email'].toString(),
            u['user2Email'].toString(),
            u['lastMessage'].toString());
        chatdialoglist.add(post);
      }

      setState(() {
        hasData = false;
      });

      //EasyLoading.showSuccess("Logged in");

      //  EasyLoading.dismiss();
    }
  }
}
