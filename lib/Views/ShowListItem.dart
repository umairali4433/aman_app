import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;

class ShowListItem extends StatefulWidget {
  var ge  = '';
  ShowListItem(this.ge);
  @override
  _ShowListItemState createState() => _ShowListItemState(ge);
}

class _ShowListItemState extends State<ShowListItem>  with SingleTickerProviderStateMixin{
  var bollcheck = true;
  var get = '';
  _ShowListItemState(this.get);
  List<chatsdialogmodel> getitemlist = [];

  @override
  void initState() {
    print(get);
   // getLatestData();
  }

//  Future<void> getLatestData() async {
//    Map<String, String> requestHeaders = {
//      'Content-type': 'application/json',
//      'Accept': 'application/json',
//      'Authorization': 'Basic d2FoaWRAd2FoaWQuY29tIDEyMw==',
//    };
//
//    Uri uri = Uri.parse("http://sarosh-001-site1.itempurl.com/api/files/1");
//
//    var response = await http.get(uri, headers: requestHeaders);
//
//    if (response.statusCode == 401) {
//      print('error');
//    } else if (response.statusCode == 200) {
//      var responseJson = json.decode(response.body);
//      for (var u in responseJson) {
//        chatsdialogmodel post = chatsdialogmodel.a1(
//            u['fileName'].toString(),
//            u['contentType'].toString(),
//            u['data'].toString(),
//            u['path'].toString());
//        getitemlist.add(post);
//      }
//      setState(() {
//        bollcheck  = false;
//      });
//
//      print(getitemlist[0].fileName);
//      print(getitemlist[1].contentType);
//      print(getitemlist[2].data);
//    }
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(get),
      ),
      body: ListView.builder(
          itemCount: 8,
          itemBuilder: (context, index) {
            return  Column(
              children: [

               Image.asset('assets/images/123.png'),
                SizedBox(
                  height: 20,
                ),


              ],
            );
          }),
    );
  }
}

class chatsdialogmodel {
  String fileName, contentType, data, path;

  chatsdialogmodel.a1(this.fileName, this.contentType, this.data, this.path);
}
