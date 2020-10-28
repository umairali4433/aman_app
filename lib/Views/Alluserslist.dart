import 'dart:convert';

import 'package:aman_app/Cons/Constants.dart';
import 'package:aman_app/model/chatsdialogmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;

import 'chat2.dart';

class Allusers extends StatefulWidget {
  @override
  _AllusersState createState() => _AllusersState();
}

class _AllusersState extends State<Allusers>  with SingleTickerProviderStateMixin{
  List<chatsdialogmodel> getalluserlist = [];
  var hasData = true;

  @override
  void initState() {
    getallusers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      appBar: AppBar(
        title: Text('All Users'),
        backgroundColor: Colors.blueGrey.shade900,
      ),
      body: hasData
          ? Center(
        child: SpinKitSquareCircle(
          color: Colors.white,
          size: 50.0,
          controller: AnimationController(
              vsync: this, duration: const Duration(milliseconds: 1200)),
        ),
      )
          : ListView.builder(
              itemBuilder: (context, index) {
                return Column(
                  children: <Widget>[
                    GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ChatTwoPage(getalluserlist[index].lastMessage)),
                        );
                      },
                      child: ListTile(
                        title: Text(
                          getalluserlist[index].dialogId,
                          style: TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(getalluserlist[index].user1Email,
                            style: TextStyle(color: Colors.white)),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://aman.paknavy.gov.pk/images/logo.png'),
                        ),
                        trailing: Text(getalluserlist[index].user2Email,style: TextStyle(color: Colors.white)),
                      ),
                    ),
                    Divider(
                      color: Colors.white.withOpacity(.2),
                      height: 0.5,
                    )
                  ],
                );

              },
              itemCount: getalluserlist.length,
            ),
    );
  }

  Future<void> getallusers() async {
    Codec<String, String> stringToBase64 = utf8.fuse(base64);

    String encoded = stringToBase64.encode('wahid@wahid.com 123');
//asdsadasd
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Basic ' + encoded,
    };

    final response = await http.get(
      Base_url+'users',
      headers: requestHeaders,
    );

    if (response.statusCode == 401) {
      print("you are not authorized user");
      setState(() {
        hasData = true;
      });
    } else if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);

      for (var u in responseJson) {

        chatsdialogmodel post = chatsdialogmodel(
            u['name'].toString(), u['email'].toString(), u['levels'],u['id'].toString());
        getalluserlist.add(post);
      }
      setState(() {
        hasData = false;
      });
      //EasyLoading.showSuccess("Logged in");

      //  EasyLoading.dismiss();
    }
  }
}
