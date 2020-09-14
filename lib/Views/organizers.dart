import 'package:aman_app/Views/speakers.dart';
import 'package:aman_app/model/getlink.dart';
import 'package:aman_app/model/getlist.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Leaders.dart';

class organizers extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<organizers> {
  List<getlist> getalldatalist = [];
  @override
  void initState() {
    List<getlink> get1 = [];
    get1.add(getlink('Speakers','123'));
    get1.add(getlink('Leaders','1231'));
    getalldatalist.add(getlist('Organizers','assets/images/organizer.jpg', 'Organizers', get1));
  }
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
                                      getalldatalist[int].getlinklist[int2].key,
                                      style: TextStyle(
                                          color: Colors.blueGrey.shade900,
                                          fontSize: 15),
                                    ),
                                  ),
                                ),
                                onTap: (){
                                 check(int2);
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

  void check(int index) {
    if(index == 1){
      Navigator.push(context, MaterialPageRoute(builder: (context) => Leaders()));
    }
    else{
      Navigator.push(context, MaterialPageRoute(builder: (context) => speakers()));
    }
  }
}
