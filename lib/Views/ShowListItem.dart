import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;

class ShowListItem extends StatefulWidget {
  @override
  _ShowListItemState createState() => _ShowListItemState();
}

class _ShowListItemState extends State<ShowListItem>  with SingleTickerProviderStateMixin{
  var bollcheck = true;
  List<chatsdialogmodel> getitemlist = [];

  @override
  void initState() {
    getLatestData();
  }

  Future<void> getLatestData() async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Basic d2FoaWRAd2FoaWQuY29tIDEyMw==',
    };

    Uri uri = Uri.parse("http://sarosh-001-site1.itempurl.com/api/files/1");

    var response = await http.get(uri, headers: requestHeaders);

    if (response.statusCode == 401) {
      print('error');
    } else if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      for (var u in responseJson) {
        chatsdialogmodel post = chatsdialogmodel.a1(
            u['fileName'].toString(),
            u['contentType'].toString(),
            u['data'].toString(),
            u['path'].toString());
        getitemlist.add(post);
      }
      setState(() {
        bollcheck  = false;
      });

      print(getitemlist[0].fileName);
      print(getitemlist[1].contentType);
      print(getitemlist[2].data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Colors.blueGrey.shade900.withOpacity(0.8),
          Colors.blueGrey.shade900
        ], begin: Alignment.topRight, end: Alignment.bottomLeft)),
        child: ListView.builder(
            itemCount: getitemlist.length,
            itemBuilder: (context, index) {
              return bollcheck ?  Center(
              child: SpinKitSquareCircle(
              color: Colors.white,
              size: 50.0,
              controller: AnimationController(
              vsync: this, duration: const Duration(milliseconds: 1200)),
              )
              ) : Image.network(
                'https://i.pinimg.com/originals/a1/d9/11/a1d9118beba75f34c03e2cac36b39c9e.jpg',
                scale: 1.0,
                width: double.infinity,
                fit: BoxFit.cover,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.white,
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes
                          : null,
                    ),
                  );
                },
              );
            }),
      ),
    );
  }
}

class chatsdialogmodel {
  String fileName, contentType, data, path;

  chatsdialogmodel.a1(this.fileName, this.contentType, this.data, this.path);
}
