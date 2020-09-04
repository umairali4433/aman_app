import 'dart:convert';

import 'package:aman_app/main.dart';
/**
 * Author: Siddhartha Joshi
 * profile: https://github.com/cimplesid
 */

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:aman_app/model/chatsdialogmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Alluserslist.dart';
import 'chat2.dart';

class ChatUi extends StatefulWidget {
  chatsubstate createState() => chatsubstate();
}

class chatsubstate extends State<ChatUi> with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<chatsdialogmodel> chatdialoglist = [];
  static final String path = "lib/src/pages/misc/chatui.dart";

  var hasData = true;

  @override
  void initState() {
    getchats();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
                      return Column(
                        children: <Widget>[
                          GestureDetector(
                            onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => ChatTwoPage(chatdialoglist[index].dialogId)),
                              );
                            },
                            child: ListTile(
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
                            ),
                          ),
                          Divider(
                            color: Colors.white.withOpacity(.2),
                            height: 0.5,
                          )
                        ],
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
    final ore = await SharedPreferences.getInstance();
    if (ore.getString('counter') == null){
      _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text('Please sign in first'),
      duration: Duration(seconds: 3),
    ));
//      Future.delayed(Duration(seconds: 3));
//      Navigator.push(
//        context,
//        MaterialPageRoute(builder: (context) => MyApp()),
//      );
    }
    else{

      Map<String, String> requestHeaders = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Basic ' + ore.getString('counter'),
      };
      final response = await http.get(
        'http://sarosh-001-site1.itempurl.com/api/dialogs/' + ore.getString('id'),
        headers: requestHeaders,
      );

      if (response.statusCode == 401) {
        print("you are not authorized user");
      } else if (response.statusCode == 200) {
        var responseJson = json.decode(response.body);
        for (var u in responseJson) {





          var getid = '';
          if((ore.getString('id')!=u['user1Id'].toString())){
          getid =u['user1Id'].toString();
          }
          else if(ore.getString('id')!=u['user2Id'].toString()){
            getid =u['user2Id'].toString();
          }
          chatsdialogmodel post = chatsdialogmodel(
              getid,
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
}
