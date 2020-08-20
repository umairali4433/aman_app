

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {

  @override
  loginstate createState() => loginstate();

}


class loginstate extends State<Login>{


  Map<String, String> requestHeaders = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Basic d2FoaWRAd2FoaWQuY29tIDEyMw==',
    'Email': 'wahid@wahid.com'
  };

  Future<Album> fetchAlbum() async {
    final response = await http.get(
      'http://sarosh-001-site1.itempurl.com/api/users/auth',
      headers: requestHeaders,
    );
    final responseJson = json.decode(response.body);

    return Album.fromJson(responseJson);
  }



  @override
  void initState() {
    super.initState();
    fetchAlbum();


  }
  @override
  Widget build(BuildContext context) {


  }

}

class Album {
  final int userId;
  final int id;
  final String title;

  Album({this.userId, this.id, this.title});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
    );
  }
}