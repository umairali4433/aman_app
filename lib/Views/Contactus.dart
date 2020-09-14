import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'Home.dart';
import 'Login.dart';

class contactus extends StatefulWidget {
  @override
  _contactusState createState() => _contactusState();
}

class _contactusState extends State<contactus> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var hasData = true;
  String name, desg, telephone, email;


  @override
  void initState() {
   // getchats();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade900,
        title: Text('Contact Us'),
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
      key: _scaffoldKey,
      body
          : Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    ClipPath(
                      clipper: WaveClipper2(),
                      child: Container(
                        child: Column(),
                        width: double.infinity,
                        height: 300,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              Color(0xff074880).withOpacity(0.9),
                              Color(0xff074880).withOpacity(0.8)
                            ])),
                      ),
                    ),
                    ClipPath(
                      clipper: WaveClipper3(),
                      child: Container(
                        child: Column(),
                        width: double.infinity,
                        height: 300,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              Colors.indigo.shade900,
                              Color(0xff074880).withOpacity(0.5)
                            ])),
                      ),
                    ),
                    ClipPath(
                      clipper: WaveClipper1(),
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 40,
                            ),
//                      Icon(
//                        Icons.fastfood,
//                        color: Colors.white,
//                        size: 60,
//                      ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Contact Us",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 30),
                            ),
                          ],
                        ),
                        width: double.infinity,
                        height: 300,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [Color(0xff074880), Color(0xff074880)])),
                      ),
                    ),
                  ],
                ),
                Card(
                  elevation: 3,
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Name',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 67,
                        ),
                        Text('Wahid'),
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 3,
                  margin: EdgeInsets.only(left: 16, right: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[
                        Text('Designation',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                        SizedBox(
                          width: 20,
                        ),
                        Text("Am"),
                      ],
                    ),
                  ),
                ),
                Card(

                  elevation: 3,
                  margin: EdgeInsets.only(left: 16, right: 16, top: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[
                        Text('Telephone',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                        SizedBox(
                          width: 35,
                        ),
                        Text('021-31258745'),
                        Spacer(),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.call,
                            color: Colors.blueGrey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 3,
                  margin: EdgeInsets.only(left: 16, right: 16, top: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[
                        Text('Email',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                        SizedBox(
                          width: 75,
                        ),
                        Text('Wahid@gmail.com'),
                        Spacer(),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.email,
                            color: Colors.blueGrey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Future<void> getchats() async {
    final ore = await SharedPreferences.getInstance();
    if (ore.getString('counter') == null) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Please sign in first'),
        duration: Duration(seconds: 3),
      ));
    } else {
      Map<String, String> requestHeaders = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Basic ' + ore.getString('counter'),
      };
      final response = await http.get(
        'http://sarosh-001-site1.itempurl.com/api/contactus',
        headers: requestHeaders,
      );

      if (response.statusCode == 401) {
        print("you are not authorized user");
      }
      else if (response.statusCode == 200) {
        print('200');
        var responseJson = json.decode(response.body);
        name = responseJson[0]['name'].toString();
        desg = responseJson[0]['designation'].toString();
        telephone = responseJson[0]['telephone'].toString();
        email = responseJson[0]['email'].toString();

        setState(() {
          hasData = false;
        });

        //EasyLoading.showSuccess("Logged in");

        //  EasyLoading.dismiss();
      }
    }
  }
}
