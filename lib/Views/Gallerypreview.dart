import 'dart:convert';

import 'package:aman_app/Cons/Constants.dart';
import 'package:aman_app/Views/Gallery.dart';
import 'package:aman_app/model/chatsdialogmodel.dart';
import 'package:aman_app/model/getlink.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'ChatUI.dart';
import 'Login.dart';

class Gallerypreview extends StatefulWidget {
  @override
  _GallerypreviewState createState() => _GallerypreviewState();
}

class _GallerypreviewState extends State<Gallerypreview> {
  List<chatsdialogmodel> getgallerylist = [];
  bool hasData = true;
  @override
  void initState() {
    getgallerypreview();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.chat),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ChatUi()),
            );
          },
        ),
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade900,
      title: Text('Gallery'),
      ),
      body: hasData?  Center(
    child: SpinKitSquareCircle(
    color: Colors.blueGrey.shade900,
      size: 50.0,
    ),
    ):ListView.builder(
    padding: EdgeInsets.only(top: 20),
    itemBuilder: (context, index) {
    return Column(
    children: [
    GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Gallery(getgallerylist[index].dialogId)),
        );

      },
      child: ListTile(

      title: Text(getgallerylist[index].user1Email),
        trailing: Icon(Icons.arrow_forward_ios_outlined),



      ),
    )  ,
    Divider(
    height: 50,
    )
    ],
    );

    },
    itemCount: getgallerylist.length,
    ));

  }

  void getgallerypreview() async {

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
        Base_url+'GalleryTypes',
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


          chatsdialogmodel post = chatsdialogmodel.a1(
              u['id'].toString(), u['type'].toString(),'');
          getgallerylist.add(post);
        }
        setState(() {
          hasData = false;
        });
      }

    }

  }
}
