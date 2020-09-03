import 'dart:async';
import 'dart:convert';

import 'package:aman_app/main.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginSevenPage extends StatefulWidget {
  static final String path = "lib/src/pages/login/login7.dart";

  @override
  _LoginSevenPageState createState() => _LoginSevenPageState();
}

class _LoginSevenPageState extends State<LoginSevenPage>
    with TickerProviderStateMixin {
  @override
  final RoundedLoadingButtonController _btnController =
      new RoundedLoadingButtonController();

  void initState() {
    super.initState();
  }

  final emailtext = TextEditingController();

  final password = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: ListView(
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
                      Icon(
                        Icons.fastfood,
                        color: Colors.white,
                        size: 60,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Pak Navy",
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
          SizedBox(
            height: 80,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: Material(
              elevation: 2.0,
              borderRadius: BorderRadius.all(Radius.circular(30)),
              child: TextField(
                onChanged: (String value) {},
                cursorColor: Color(0xff074880),
                decoration: InputDecoration(
                    hintText: "Email",
                    prefixIcon: Material(
                      elevation: 0,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      child: Icon(
                        Icons.email,
                        color: Color(0xff074880),
                      ),
                    ),
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 25, vertical: 13)),
                controller: emailtext,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: Material(
              elevation: 2.0,
              borderRadius: BorderRadius.all(Radius.circular(30)),
              child: TextField(
                onChanged: (String value) {},
                cursorColor: Color(0xff074880),
                decoration: InputDecoration(
                    hintText: "Password",
                    prefixIcon: Material(
                      elevation: 0,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      child: Icon(
                        Icons.lock,
                        color: Color(0xff074880),
                      ),
                    ),
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 25, vertical: 13)),
                obscureText: true,
                controller: password,
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Container(
                  child: RoundedLoadingButton(
                      color: Color(0xff074880),
                      child:
                          Text('LogIn', style: TextStyle(color: Colors.white)),
                      controller: _btnController,
                      onPressed: () {
                        getuser(context);
                      }))),
        ],
      ),
    );
  }

  void getuser(BuildContext context) {
    if (emailtext.text.isEmpty && password.text.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Please fill out the textfields above'),
        duration: Duration(seconds: 3),
      ));
    } else {
      fetchUserData();
    }
  }

  Future<getusermodel> fetchUserData() async {
    Codec<String, String> stringToBase64 = utf8.fuse(base64);

    String encoded =
        stringToBase64.encode(emailtext.text + ' ' + password.text);

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Basic ' + encoded,
    };

    final response = await http.get(
      'http://sarosh-001-site1.itempurl.com/api/users/auth',
      headers: requestHeaders,


    );

    if (response.statusCode == 401) {
      _btnController.error();
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('You are not the authorized user'),
        duration: Duration(seconds: 2),
      ));
      Future.delayed(Duration(seconds: 1))
          .then((value) => _btnController.reset());
    } else if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('counter', encoded);
      await prefs.setString('id', responseJson['id'].toString());
      _btnController.success();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MyApp()),
      );
      //EasyLoading.showSuccess("Logged in");

      //  EasyLoading.dismiss();

    }
  }
}

class getusermodel {
  int userId;

  String name, rank, email, country, password, levels, status;

  getusermodel(
      {this.userId,
      this.rank,
      this.email,
      this.country,
      this.password,
      this.levels,
      this.status});
}

class WaveClipper1 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    path.lineTo(0.0, size.height - 50);

    var firstEndPoint = Offset(size.width * 0.6, size.height - 29 - 50);

    var firstControlPoint = Offset(size.width * .25, size.height - 60 - 50);

    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondEndPoint = Offset(size.width, size.height - 60);

    var secondControlPoint = Offset(size.width * 0.84, size.height - 50);

    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, size.height);

    path.lineTo(size.width, 0);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class WaveClipper3 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    path.lineTo(0.0, size.height - 50);

    var firstEndPoint = Offset(size.width * 0.6, size.height - 15 - 50);

    var firstControlPoint = Offset(size.width * .25, size.height - 60 - 50);

    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondEndPoint = Offset(size.width, size.height - 40);

    var secondControlPoint = Offset(size.width * 0.84, size.height - 30);

    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, size.height);

    path.lineTo(size.width, 0);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class WaveClipper2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    path.lineTo(0.0, size.height - 50);

    var firstEndPoint = Offset(size.width * .7, size.height - 40);

    var firstControlPoint = Offset(size.width * .25, size.height);

    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondEndPoint = Offset(size.width, size.height - 45);

    var secondControlPoint = Offset(size.width * 0.84, size.height - 50);

    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, size.height);

    path.lineTo(size.width, 0);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
