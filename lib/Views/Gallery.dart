import 'dart:convert';

import 'package:aman_app/Cons/Constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;

import 'ChatUI.dart';
import 'Home.dart';

class Gallery extends StatefulWidget {
  @override
  String getindex;
  Gallery(this.getindex);

  mainstate createState() => mainstate(getindex);
}


class mainstate extends State<Gallery> {
  final List<String> imagesList = [];
  List<String> getlinklistforslider  = [];
  String getindex;
  mainstate(this.getindex);
  var check = true;
  @override
  void initState() {
    getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return check? Center(
      child: SpinKitSquareCircle(
        color: Colors.blueGrey.shade900,
        size: 50.0,
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
        title: Text('Gallery'),
        backgroundColor: Colors.blueGrey.shade900,
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
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            childAspectRatio: 1),
        itemBuilder: (context, index) {
          return Card(

            color: Colors.grey,
              elevation: 6,
              shape: RoundedRectangleBorder(
                  side: new BorderSide(color: Colors.blueGrey.shade900, width: 1),
                  borderRadius: BorderRadius.circular(10)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: getlinklistforslider[index]=='Test'?Image.asset('assets/images/realone.png'):
                    Image.network(
                  'http://'+getlinklistforslider[index],
                  scale: 1.0,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.blueGrey.shade900),
                        backgroundColor: Colors.grey.shade400,
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes
                            : null,
                      ),
                    );
                  },
                ),
              ),
          );
        },
        itemCount: getlinklistforslider.length,
      ),
    );
  }

  void getdata() async {
    var response = await http.get(Base_url+'galleries/'+getindex);

    if (response.statusCode == 401){
      print('error');
    }

    else if(response.statusCode == 200){
      var responseJson = json.decode(response.body);
      for (var u in responseJson) {
        getlinklistforslider.add((u['imagePath'].toString()));
      }
      setState(() {
        check = false;
        print('done');
      });


    }
  }
}
