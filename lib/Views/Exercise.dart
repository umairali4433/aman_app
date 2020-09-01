import 'dart:core';

import 'package:aman_app/Views/Login.dart';
import 'package:aman_app/Views/showdatalist.dart';
import 'package:aman_app/model/getlist.dart';
import 'package:aman_app/model/getlink.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';



class asd extends StatelessWidget {
  String getthis;
  asd(this.getthis);
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class Exercise extends StatefulWidget {
  String get;
  Exercise(get);
  sub createState() => sub(get);

}
class sub extends State<Exercise>{
  List<getlist> getalldatalist = [];
  String get;
  sub(get);

  @override
  void initState() {
    print(get);
    List<String> get1 = ['Harbour Phase','Sea Phase'];
    List<String> get2 = ['Opening Ceremony','Reception Dinner','IMC','Band Display & CT Demo','Food Gala & cultural show','IFR(internal fleet review)'];
    List<String> get3 = ['Events','Date & time'];
   getalldatalist.add(getlist('Activities',get1));
    getalldatalist.add(getlist('Events',get2));
    getalldatalist.add(getlist('Scedule',get3));
  }




  final Color primary = Color(0xff7b7517);
  final Color background = Color(0xff2f2f4f);
  final Color overlay = Color(0xff212129);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(

        shrinkWrap: true,
        itemCount: getalldatalist.length,
        itemBuilder: (ctx,int){
          return Container(
            margin: EdgeInsets.all(4),
            child: Column(
              children: [
                Container(
                  height:MediaQuery.of(context).size.height*.3,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: AssetImage('assets/images/background.jpeg'),
                          //radius kese dete the?
                          fit: BoxFit.cover)

                  ),
                  child: Column(

                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(

                          color: Colors.black54,

                          child: Text(getalldatalist[int].key,style: TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.bold),)),
                      SizedBox(
                        height: 50,
                      ),
                      Container(
                        height: 50.0,
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: getalldatalist[int].getlinklist.length,
                            itemBuilder: (BuildContext context, int2) =>


                                GestureDetector(
                                  onTap: (){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => showdatalist('sdfsdfs')),
                                    );
                                  },
                                  child: Container(
                              margin: EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30.0),
                                    color: Theme.of(context).primaryColor),
                              child: Padding(
                                  padding: EdgeInsets.all(9),
                                  child: Text(
                                    getalldatalist[int].getlinklist[int2],
                                    style: TextStyle(color: Colors.white,fontSize: 15),
                                  ),
                              ),
                            ),
                                )
                        ),
                      ),


                    ],
                  ),

                  //setha??

                  //ub sun yr decoration nh chl rhee pta nh q is lis main ruk dikata hn
//                 child: Image.asset('assets/images/background.jpeg',fit: BoxFit.cover),

                ),

                SizedBox(
                  height: 5,
                )
              ],
            ),
          );
        },
      ),
    );

  }


}
