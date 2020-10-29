import 'dart:core';
import 'package:aman_app/Views/Login.dart';
import 'package:aman_app/model/getlink.dart';
import 'package:aman_app/model/getlist.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:aman_app/Views/ShowListItem.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ChatUI.dart';
import 'Home.dart';

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
  void initState()  {
    validate();
  }

  final Color primary = Color(0xff7b7517);
  final Color background = Color(0xff2f2f4f);
  final Color overlay = Color(0xff212129);
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.chat),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ChatUi()),
            );

          },
        ),

        appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade900,
        title: Text(
          'Exercise Aman 2021',
          style: TextStyle(
            fontSize: 18,
            letterSpacing: 2,
          ),
        ),
        actions: <Widget>[

          IconButton(icon: Icon(Icons.home), onPressed: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ExpansionTileSample()),
            );
          }),
        ],

      ),

      backgroundColor: Colors.blueGrey.shade900,
      body: Stack(
        children: <Widget>[

          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    colorFilter: ColorFilter.mode(
                        Colors.blueGrey.shade900.withOpacity(0.2), BlendMode.color),
                    image: AssetImage('assets/images/backgroundnewone.jpg'),
                    fit: BoxFit.cover)),
          ),
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    colorFilter: ColorFilter.mode(
                        Colors.blueGrey.shade900.withOpacity(0.5), BlendMode.color),
                    image: AssetImage('assets/images/realone.png'),
                    fit: BoxFit.fitWidth)),

          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: getalldatalist.length,
            itemBuilder: (ctx, int) {
              return Container(
                color: Colors.blue.withOpacity(0.4),
                margin: EdgeInsets.all(2),
                child: Column(
                  children: [
                    Card(
                      elevation:3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(bottom: Radius.circular(0),top: Radius.circular(20))
                      ),
                      child: Container(
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
                                            getalldatalist[int].getlinklist[int2].key,
                                            style: TextStyle(
                                                color: Colors.blueGrey.shade900,
                                                fontSize: 15),
                                          ),
                                        ),
                                      ),
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => ShowListItem(getalldatalist[int].getlinklist[int2].key,getalldatalist[int].getlinklist[int2].value)));
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

                    ),
                    SizedBox(
                      height: 1,
                    )
                  ],
                ),
              );
            },
          ),
        ],
      )
    );
  }

  void validate()  async{
    final ore = await SharedPreferences.getInstance().then((value){
      if (value.getString('counter') != null){
        print(getval);
        if (getval == '0') {
          List<getlink> get1 = [];
          get1.add(getlink("Harbour Phase","1"));
          get1.add( getlink('Sea Phase', '2'));

          List<getlink> get2 = [];
          get2.add(getlink('Opening Ceremony',"3"));
          get2.add(getlink('Reception Dinner',"4"));
          get2.add(getlink('IMC',"5"));
          get2.add(getlink('Band Display & CT Demo',"6"));
          get2.add(getlink('Food Gala & cultural show',"7"));
          get2.add(getlink('IFR(International Fleet review)',"8"));

          List<getlink> get3 = [];
          get3.add(getlink('Events Date & time', '9'));
          getalldatalist
              .add(getlist('Exercise','assets/images/activities.jpeg', 'Activities', get1));
          getalldatalist.add(getlist('','assets/images/events.jpg', 'Events', get2));
          getalldatalist.add(getlist('','assets/images/schedule.jpg', 'Schedule', get3));
        }
        else if (getval == "1") {
          List<getlink> get1 = [];
          get1.add(getlink('Harbour Facilities','10'));
          get1.add(getlink('Logistics','11'));
          get1.add(getlink('Admin Assistance','12'));
          get1.add(getlink('Berth','13'));
          get1.add(getlink('Tugs','14'));
          get1.add(getlink('Pilots','15'));
          getalldatalist.add(getlist('Service & Support','assets/images/service.jpg', 'Service & Support', get1));

        }
        else if (getval == "3") {
          List<getlink> get1 = [];
          get1.add(getlink('Speakers','16'));
          get1.add(getlink('Leaders','1231'));
          //  getalldatalist.add(getlist('Organizers','assets/images/organizer.jpg', 'Organizers', get1));
        } else if (getval == '5') {
          List<String> get1 = ['Contact us', 'FeedBack','Query','ChatBox'];
          //getalldatalist.add(getlist('Contact Us','assets/images/contact.jpg', 'Contact Us', get1));
        } else if (getval == '6') {
          List<getlink> get1 = [];
          get1.add(getlink('Official Chandler','17'));
          get1.add(getlink('Media Partners','19'));

          getalldatalist.add(getlist('Misc','assets/images/misc.jpg', 'Misc', get1));
        }
        setState(() {
          getalldatalist;
        });
      }
      else{
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginSevenPage()),
        );
      }
    });

  }

}
