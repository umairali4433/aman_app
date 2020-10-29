import 'dart:convert';

import 'package:aman_app/Cons/Constants.dart';
import 'package:aman_app/Views/ChatUI.dart';
import 'package:aman_app/model/getlink.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:aman_app/model/chatsdialogmodel.dart';

import 'Home.dart';
import 'Login.dart';

class Participants extends  StatefulWidget {

  chatsubstate createState() => chatsubstate();

}
class chatsubstate extends State<Participants> with SingleTickerProviderStateMixin{
  List<chatsdialogmodel> getlinklist   = [];
  bool hasData = true;
  @override
  void initState() {
    getcountries();
    // getlinklist.add(getlink('https://aman.paknavy.gov.pk/Images/china.png','China'));
    // getlinklist.add(getlink('https://aman.paknavy.gov.pk/Images/Ukraine.png','Ukraine'));
    // getlinklist.add(getlink('https://aman.paknavy.gov.pk/Images/Tunisia.png','Tunisa'));
    // getlinklist.add(getlink('https://aman.paknavy.gov.pk/Images/Palestine.png','Palestine'));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return

      hasData?Center(
        child: SpinKitSquareCircle(
          color: Colors.white,
          size: 50.0,
          controller: AnimationController(
              vsync: this, duration: const Duration(milliseconds: 1200)),
        ),
      ):Scaffold(

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
          title: Text('Participants'),
          actions: <Widget>[

            IconButton(icon: Icon(Icons.home), onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ExpansionTileSample()),
              );
            }),
          ],
        ),
        body: ListView.builder(
          padding: EdgeInsets.only(top: 20),
          itemBuilder: (context, index) {
            return Column(
              children: [
                ListTile(

                  title: Text(getlinklist[index].user1Email),
                  trailing:  getlinklist[index].user2Email=='Test'?Text('bhai'):Text('bhen'),


                )  ,
                Divider(
                  height: 50,
                )
              ],
            );

          },
          itemCount: getlinklist.length,
        ));

  }

  void getcountries()  async{
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
        Base_url+'countries',
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
              u['id'].toString(), u['countryName'].toString(), u['imagePath']);
          getlinklist.add(post);
        }
        setState(() {
          hasData = false;
        });
    }

  }

  }

}