import 'dart:core';

import 'package:aman_app/model/getlist.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:aman_app/Views/ShowListItem.dart';

class Exercise extends StatefulWidget {
  String get;

  Exercise(this.get);

  sub createState() => sub(get);
}

class sub extends State<Exercise> {
  String getval;

  sub(this.getval);

  List<getlist> getalldatalist = [];

  @override
  void initState() {
    if (getval == "0") {
      List<String> get1 = ['Harbour Phase', 'Sea Phase'];
      List<String> get2 = [
        'Opening Ceremony',
        'Reception Dinner',
        'IMC',
        'Band Display & CT Demo',
        'Food Gala & cultural show',
        'IFR(internal fleet review)'
      ];
      List<String> get3 = ['Events', 'Date & time'];
      getalldatalist
          .add(getlist('Exercise','assets/images/activity.jpg', 'Activities', get1));
      getalldatalist.add(getlist('','assets/images/events.jpg', 'Events', get2));
      getalldatalist
          .add(getlist('','assets/images/schedule.jpg', 'Schedule', get3));
    } else if (getval == "1") {
      List<String> get1 = [
        'Harbour Facilities',
        'Logistics',
        'Admin Assistance',
        'Berth',
        'Tugs',
        'Pilots'
      ];
      getalldatalist.add(getlist('Service & Support','assets/images/service.jpg', 'Service & Support', get1));
    } else if (getval == "2") {
      List<String> get1 = ['Opportunity', 'Plan'];
      getalldatalist.add(getlist('Participants','assets/images/part.jpg', 'Participants', get1));
    } else if (getval == "3") {
      List<String> get1 = ['Speakers', 'Leaders'];
      getalldatalist.add(getlist('Organizers','assets/images/organizer.jpg', 'Organizers', get1));
    } else if (getval == '5') {
      List<String> get1 = ['Contact us', 'FeedBack','Query','ChatBox'];
      getalldatalist.add(getlist('Contact Us','assets/images/contact.jpg', 'Contact Us', get1));
    } else if (getval == '6') {
      List<String> get1 = [
        'Official Calender',
        'FLoor Plan',
        'Media Partners'
      ];
      getalldatalist.add(getlist('Misc','assets/images/misc.jpg', 'Misc', get1));
    }
  }

  final Color primary = Color(0xff7b7517);
  final Color background = Color(0xff2f2f4f);
  final Color overlay = Color(0xff212129);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade900,
        title: Text(
          getalldatalist[0].titile,
          style: TextStyle(
            fontSize: 25,
            letterSpacing: 2,
          ),
        ),
      ),
      backgroundColor: Colors.blueGrey.shade900,
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: getalldatalist.length,
        itemBuilder: (ctx, int) {
          return Container(
            margin: EdgeInsets.all(2),
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * .3,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(0), top: Radius.circular(20)),
                      image: DecorationImage(
                          colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(1), BlendMode.dstATop),
                          image: AssetImage(getalldatalist[int].image),
                          //radius kese dete the?
                          fit: BoxFit.cover)),
                  child: Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.center,
                                child: Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: Colors.blueGrey.shade900
                                            .withOpacity(0.5),
                                        border: Border.all(color: Colors.white),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Text(
                                      getalldatalist[int].key,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(0.9),
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 2,
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 50.0,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: getalldatalist[int].getlinklist.length,
                          itemBuilder: (BuildContext context, int2) => Row(
                            children: <Widget>[
                              GestureDetector(
                                child: Container(
                                  margin: EdgeInsets.only(bottom: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30.0),
                                      color: Colors.white.withOpacity(0.7),
                                      border: Border.all(
                                          color: Colors.blueGrey.shade900,
                                          width: 2)),
                                  child: Padding(
                                    padding: EdgeInsets.all(9),
                                    child: Text(
                                      getalldatalist[int].getlinklist[int2],
                                      style: TextStyle(
                                          color: Colors.blueGrey.shade900,
                                          fontSize: 15),
                                    ),
                                  ),
                                ),
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => ShowListItem(getalldatalist[int].getlinklist[int2])));
                                },
                              ),
                              SizedBox(
                                width: 4,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  //setha??

                  //ub sun yr decoration nh chl rhee pta nh q is lis main ruk dikata hn
//                 child: Image.asset('assets/images/background.jpeg',fit: BoxFit.cover),
                ),
                SizedBox(
                  height: 1,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
