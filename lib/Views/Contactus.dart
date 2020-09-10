import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

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
    getchats();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade900,
        title: Text('Contact Us'),
      ),
      key: _scaffoldKey,
      body: hasData
          ? Center(
              child: SpinKitSquareCircle(
                color: Colors.blueGrey.shade900,
                size: 50.0,
              ),
            )
          : Column(
              children: <Widget>[
                Image.asset(
                  'assets/images/contact_us.jpg',
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                ),
                Card(
                  elevation: 3,
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'name',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 67,
                        ),
                        Text(name),
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
                        Text('designation',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                        SizedBox(
                          width: 20,
                        ),
                        Text(desg),
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
                        Text('telephone',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                        SizedBox(
                          width: 35,
                        ),
                        Text(telephone),
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
                        Text('email',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                        SizedBox(
                          width: 75,
                        ),
                        Text(email),
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
