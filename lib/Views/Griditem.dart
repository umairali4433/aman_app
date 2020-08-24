
import 'package:flutter/material.dart';

class Griditem extends StatelessWidget {

  final String title;

  Griditem(this.title);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
      Flexible(
        child: CircleAvatar(
          radius: 40,
          child: Icon(Icons.ac_unit),
        ),
      ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.black54,
          ),
          padding: EdgeInsets.symmetric(vertical: 2),
          height: 35,

         child: Center(child: Text(title,textAlign: TextAlign.center,style: TextStyle(color: Colors.white), softWrap: true)),
        )
      ],
    );
  }


}
