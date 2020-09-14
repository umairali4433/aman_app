import 'package:flutter/material.dart';

class Griditem extends StatelessWidget {
  final String title;
  Widget t;
  Icon icon;

  Griditem(this.icon, this.title, this.t);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => t),
        );
      },
      child: Column(
        children: <Widget>[
          Flexible(
            child: CircleAvatar(
              radius: 30,
              backgroundColor: Color(0xff074880).withOpacity(0.6),
              child: icon,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.black.withOpacity(0.8),
            ),
            padding: EdgeInsets.symmetric(vertical: 2),
            height: 35,
            child: Center(
                child: Text(title,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),

                    softWrap: true)),
          )
        ],
      ),
    );
  }
}
