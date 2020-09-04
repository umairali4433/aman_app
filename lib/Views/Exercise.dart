import 'dart:core';

import 'package:aman_app/model/getlist.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class Exercise extends StatefulWidget {

  String get;
  Exercise(this.get);
  sub createState() => sub(get);
}
class sub extends State<Exercise>{
  String getval;
  sub(this.getval);
  List<getlist> getalldatalist = [];
  @override
  void initState() {
   if(getval =="0"){
     List<String> get1 = ['Harbour Phase','Sea Phase'];
     List<String> get2 = ['Opening Ceremony','Reception Dinner','IMC','Band Display & CT Demo','Food Gala & cultural show','IFR(internal fleet review)'];
     List<String> get3 = ['Events','Date & time'];
     getalldatalist.add(getlist('Activities',get1));
     getalldatalist.add(getlist('Events',get2));
     getalldatalist.add(getlist('Scedule',get3));
   }
   else if(getval =="1"){
     List<String> get1 = ['Harbour Facilities','Logistics','Admin Assistance','Berth','Tugs','Pilots'];
     getalldatalist.add(getlist('Service & Support',get1));
   }
   else if(getval =="2"){
   }
   else if(getval =="3"){
     List<String> get1 = ['Speakers','Leaders'];
     getalldatalist.add(getlist('Organizers',get1));
   }
   else if(getval ==4){
     List<String> get1 = ['Speakers','Leaders'];
     getalldatalist.add(getlist('Organizers',get1));
   }
   else if(getval ==5){
     List<String> get1 = ['Speakers','Leaders'];
     getalldatalist.add(getlist('Organizers',get1));
   }
   else if(getval ==6){
     List<String> get1 = ['Official Callender','FLoor Plan','Media Partners'];
     getalldatalist.add(getlist('Misc',get1));
   }


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
                            itemBuilder: (BuildContext context, int2) => Container(

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
