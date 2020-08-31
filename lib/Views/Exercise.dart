import 'dart:core';

import 'package:aman_app/Views/Login.dart';
import 'package:aman_app/model/getlink.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';




class Exercise extends StatefulWidget {
  sub createState() => sub();
}
class sub extends State<Exercise>{
  List<getlink> getalldatalist = [];

  @override
  void initState() {
    List<String> get1 = ['Harbour Phase','Sea Phase'];
    List<String> get2 = ['Opening Ceremony','Reception Dinner','IMC','Band Display & CT Demo','Food Gala & cultural show','IFR(internal fleet review)'];
    List<String> get3 = ['Events','Date & time'];
   getalldatalist = [new getlink.a2('Activities',get1),new getlink.a2('Events',get2),new getlink.a2('Scedule',get3)];
  }




  final Color primary = Color(0xff7b7517);
  final Color background = Color(0xff2f2f4f);
  final Color overlay = Color(0xff212129);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(

      shrinkWrap: true,
      itemCount: getalldatalist.length,
      itemBuilder: (ctx,int){
        return Container(
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
                    Text(getalldatalist[int].key+" "+getalldatalist[int].getlinklist[int]),
                    Container(
                      height: 60.0,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: 15,
                          itemBuilder: (BuildContext context, int) => Container(
                            margin: EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30.0),
                                color: Theme.of(context).primaryColor),
                            child: Padding(
                              padding: EdgeInsets.all(9),
                              child: Text(
                                "gotthis on",
                                style: TextStyle(color: Colors.white,fontSize: 25),
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
                height: 20,
              )
            ],
          ),
        );
      },
    );

  }


}
