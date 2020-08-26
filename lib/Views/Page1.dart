import 'package:aman_app/model/getlink.dart';
import 'package:flutter/cupertino.dart';

import '../main.dart';
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
    gettitlelist.add(getlink.a1('Home',ExpansionTileSample()));
    gettitlelist.add(getlink.a1('Exercise',Exercise()));
    gettitlelist.add(getlink.a1('Service & Support',null));
    gettitlelist.add(getlink.a1('Participants',null));
    gettitlelist.add(getlink.a1('Organizers',null));
    gettitlelist.add(getlink.a1('Misc',null));
    gettitlelist.add(getlink.a1('Gallery',null));
    gettitlelist.add(getlink.a1('Contact us',null));
    gettitlelist.add(getlink.a1('Login/Logout',LoginSevenPage()));


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
        itemBuilder: (context, index) => Griditem(gettitlelist[index].key,gettitlelist[index].test),
        itemCount: gettitlelist.length,
      ),
    );
  }

 
}
