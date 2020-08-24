import 'package:flutter/cupertino.dart';

import 'Griditem.dart';

class page1 extends StatelessWidget {

  List<String> gettitlelist = ['Home','Exercise','Service & Support','Participants','Organizers','Misc','Gallert','Contact us','Login/Logout'];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GridView.builder(
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 10/10,
            crossAxisCount: 3, crossAxisSpacing: 10, mainAxisSpacing: 60),
        itemBuilder: (context, index) => Griditem(gettitlelist[index]),
        itemCount: gettitlelist.length,
      ),
    );
  }
}
