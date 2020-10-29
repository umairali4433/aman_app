import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Home.dart';

class feedback extends StatefulWidget {
  @override
  _feedbackState createState() => _feedbackState();
}

class _feedbackState extends State<feedback> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    body: Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('Feedback',style: TextStyle(color: Colors.grey,fontSize: 25),),
            Text('Please give your honest Feedback about AMAN Exercise 2021',style: TextStyle(color: Colors.grey,fontSize: 12),),
            SizedBox(height: 20,),
            TextField(
              decoration: InputDecoration(

                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0)),
              ),
            )
        ],
      ),
    ),
    );


  }
}
