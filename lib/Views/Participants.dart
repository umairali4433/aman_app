import 'package:aman_app/Views/ChatUI.dart';
import 'package:aman_app/model/getlink.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Participants extends  StatefulWidget {

  chatsubstate createState() => chatsubstate();

}
class chatsubstate extends State<Participants>{
  List<getlink> getlinklist   = [];
  @override
  void initState() {
    getlinklist.add(getlink('https://aman.paknavy.gov.pk/Images/china.png','China'));
    getlinklist.add(getlink('https://aman.paknavy.gov.pk/Images/Ukraine.png','Ukraine'));
    getlinklist.add(getlink('https://aman.paknavy.gov.pk/Images/Tunisia.png','Tunisa'));
    getlinklist.add(getlink('https://aman.paknavy.gov.pk/Images/Palestine.png','Palestine'));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey.shade900,
          title: Text('Participants'),
        ),
        body: ListView.builder(
          padding: EdgeInsets.only(top: 20),
          itemBuilder: (context, index) {
            return Column(
              children: [
                ListTile(

                  title: Text(getlinklist[index].value),


                )  ,
                Divider(
                  height: 50,
                )
              ],
            );

          },
          itemCount: getlinklist.length,
        ));

  }

}