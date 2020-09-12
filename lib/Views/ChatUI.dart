import 'dart:convert';

import 'package:aman_app/Views/Login.dart';
import 'package:aman_app/main.dart';
/**
 * Author: Siddhartha Joshi
 * profile: https://github.com/cimplesid
 */

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:aman_app/model/chatsdialogmodel.dart';
import 'package:aman_app/Views/Login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Alluserslist.dart';
import 'chat2.dart';

class ChatUi extends StatefulWidget {
  chatsubstate createState() => chatsubstate();
}

class chatsubstate extends State<ChatUi> with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<chatsdialogmodel> chatdialoglist = [];
  List<chatsdialogmodel> filteredUsers = [];
  List<chatsdialogmodel> clonelist = [];
  static final String path = "lib/src/pages/misc/chatui.dart";

  var hasData = true;

  @override
  void initState() {
    getchats();
    super.initState();
  }

  @override
  void didChangeDependencies() {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chats'),
        backgroundColor: Colors.blueGrey.shade900,
      ),
      key: _scaffoldKey,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.blueGrey.shade900,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Allusers()),
          );
        },
      ),
      backgroundColor: Colors.blueGrey.shade900,
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
                          color: Colors.white54,
                        ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        borderSide: BorderSide(width: 1,color: Colors.white),
                      ),
                      border: new OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(16.0),
                        ),
                      ),),
                    onChanged: (string){
                      setState(() {
                        filteredUsers  =  clonelist
                            .where((u) => (u.user1Email
                            .toLowerCase()
                            .contains(string.toLowerCase()) ||
                            u.user2Email.toLowerCase().contains(string.toLowerCase())))
                            .toList();
                        chatdialoglist = filteredUsers;
                      });
                      if(string == ''){
                        chatdialoglist = clonelist;
                      }



                    },
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
      Future.delayed(Duration(seconds: 1));
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginSevenPage()),
      );
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
          var getid = '',getemail = '';

          if((ore.getString('useremail')==u['user1Email'].toString())){
            getemail =u['user2Email'].toString();
          }
          if((ore.getString('useremail')==u['user2Email'].toString())){
            getemail =u['user1Email'].toString();
          }



          if((ore.getString('id')!=u['user1Id'].toString())){
          getid =u['user1Id'].toString();
          }
          else if(ore.getString('id')!=u['user2Id'].toString()){
            getid =u['user2Id'].toString();
          }
          chatsdialogmodel post = chatsdialogmodel(
              getid,
              getemail,
              u['user2Email'].toString(),
              u['lastMessage'].toString());
          chatdialoglist.add(post);
        }
        filteredUsers = chatdialoglist;
        clonelist = chatdialoglist;

        setState(() {
          hasData = false;
        });

        //EasyLoading.showSuccess("Logged in");

        //  EasyLoading.dismiss();
      }
    }

  }
}
