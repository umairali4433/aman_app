import 'package:flutter/cupertino.dart';

class Exercise extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child:Expanded(
        child: new  ListView.builder(
      itemBuilder: (BuildContext context, int index) => Image.asset('assets/images/background.jpeg'),

    itemCount: 5,
    )));

  }
}
