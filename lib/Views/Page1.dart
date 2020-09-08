import 'package:aman_app/Views/Gallery.dart';
import 'package:aman_app/Views/testing.dart';
import 'package:aman_app/model/getlink.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import 'ChatUI.dart';
import 'Exercise.dart';
import 'Griditem.dart';
import 'Home.dart';

import 'Login.dart';

class page1 extends StatefulWidget {
  page1states createState() => page1states();


}
class page1states extends State<page1> {
  List<getlink> gettitlelist = [];
  @override
  void initState() {
    gettitlelist.add(getlink.a1(Icon(Icons.home,size: 35,),'Home',done()));
    gettitlelist.add(getlink.a1(Icon(Icons.explicit,size: 35),'Exercise',Exercise('0')));
    gettitlelist.add(getlink.a1(Icon(Icons.security,size: 35),'Service & Support',Exercise('1')));
    gettitlelist.add(getlink.a1(Icon(Icons.people_outline,size: 35),'Participants',Exercise('2')));
    gettitlelist.add(getlink.a1(Icon(Icons.assignment_ind,size: 35),'Organizers',Exercise('3')));
    gettitlelist.add(getlink.a1(Icon(Icons.verified_user,size: 35),'Misc',Exercise('6')));
    gettitlelist.add(getlink.a1(Icon(Icons.image,size: 35),'Gallery',Gallery()));
    gettitlelist.add(getlink.a1(Icon(Icons.contacts,size: 35),'Contact us',Exercise('5')));
    gettitlelist.add(getlink.a1(Icon(Icons.exit_to_app,size: 35),'Login/Logout',LoginSevenPage()));
    gettitlelist.add(getlink.a1(Icon(Icons.chat,size: 35),'Chat',ChatUi()));

    super.initState();
    
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GridView.builder(
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 10/10,
            crossAxisCount: 3, crossAxisSpacing: 10, mainAxisSpacing: 60),
        itemBuilder: (context, index) => Griditem(gettitlelist[index].icon,gettitlelist[index].key,gettitlelist[index].test),
        itemCount: gettitlelist.length,
      ),
    );
  }

 
}
