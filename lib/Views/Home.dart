import 'dart:convert';

/**
 * Author: Sudip Thapa
 * profile: https://github.com/sudeepthapa
 */
import 'package:aman_app/model/getlink.dart';
import 'package:flutter/material.dart';
import 'package:flutter_awesome_alert_box/flutter_awesome_alert_box.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class ExpansionTileSample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          backgroundColor: Colors.blueGrey.shade900,
        ),

        body: forbody(),
      ),
    );
  }
}

class forbody extends StatefulWidget {
  @override
  mainstate createState() => mainstate();
}

  class mainstate extends State<forbody> with TickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> animation;
  var check = true;
  TabController _tabController;
  List<String> getgalerrieslist = [
    'https://aman.paknavy.gov.pk/images/AmanPicsHome/1.jpg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
    'https://aman.paknavy.gov.pk/images/AmanPicsHome/2.jpg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
    'https://aman.paknavy.gov.pk/images/AmanPicsHome/3.jpg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
    'https://aman.paknavy.gov.pk/images/AmanPicsHome/3.jpg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
    'https://aman.paknavy.gov.pk/images/AmanPicsHome/5.jpg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
    'https://aman.paknavy.gov.pk/images/AmanPicsHome/6.jpg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
    'https://aman.paknavy.gov.pk/images/AmanPicsHome/6.jpg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
    'https://aman.paknavy.gov.pk/images/AmanPicsHome/8.jpg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260'
  ];

  List<getlink> getlinklist = [];
  List<String> getlinklistforslider  = [];

  List<Icon> iconslist = [
    Icon(Icons.cloud, size: 50, color: Colors.blueGrey.shade900),
    Icon(Icons.local_hospital, size: 50, color: Colors.blueGrey.shade900),
    Icon(Icons.home, size: 50, color: Colors.blueGrey.shade900),
    Icon(Icons.domain, size: 50, color: Colors.blueGrey.shade900),
    Icon(Icons.compare_arrows, size: 50, color: Colors.blueGrey.shade900),
    Icon(Icons.vignette, size: 50, color: Colors.blueGrey.shade900),
    Icon(Icons.filter_b_and_w, size: 50, color: Colors.blueGrey.shade900),
    Icon(Icons.switch_camera, size: 50, color: Colors.blueGrey.shade900),
  ];

  @override
  void initState() {
    super.initState();
    getdata();
    getlinklist.add(getlink('Weather Forecast \n(February, 2019)',
        'https://www.accuweather.com/en/pk/karachi/261158/month/261158?monyr=2/01/2019'));
    getlinklist.add(getlink('Medical\nFacilities\nKarachi\n  ',
        'http://www.karachisnob.com/hospitals-clinics-karachi.htm'));
    getlinklist.add(getlink('Hospitality Centre\nKarachi',
        'https://www.travel-culture.com/karachi-hotels'));


    getlinklist.add(getlink('Emergency\nNumbers\nKarachi\n  ',
        'https://www.brandsynario.com/karachi-emergency-numbers-you-must-have-on-your-phone'));

    getlinklist.add(getlink('Exchange\nRate\nPKR\n  ',
        'https://www.xe.com/currency/pkr-pakistani-rupee'));
    getlinklist.add(getlink('Sports\nCenter\nKarachi\n  ',
        'https://en.wikipedia.org/wiki/List_of_sports_venues_in_Karachi'));

    getlinklist.add(getlink('Karachi\nPort\nImportant features\n  ',
        'https://en.wikipedia.org/wiki/Port_of_Karachi'));
    getlinklist.add(getlink('More\nAbout\nKarachi\n  ',
        'https://www.karachi.com/'));
    _tabController = new TabController(length: 8, vsync: this);
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return
      check? Center(
        child: SpinKitSquareCircle(
          color: Colors.blueGrey.shade900,
          size: 50.0,
        ),
      ):
      SingleChildScrollView(
      child: Column(children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 10.0),
          height: 200,
          child: Expanded(
            child: Swiper(
              autoplay: true,
              itemBuilder: (BuildContext context, int index) {
                return new ClipRRect(
                  borderRadius: BorderRadius.circular(9.0),
                  child: Image.network(
                      'http://'+getlinklistforslider[index],
                    fit: BoxFit.fill,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes
                              : null,
                        ),
                      );
                    },
                  ),
                );
              },
              itemCount: getlinklistforslider.length,
              viewportFraction: 0.8,
              scale: 0.9,

              pagination: new SwiperPagination(),
            ),
          ),
        ),
        //slider
        SizedBox(
          height: 20.0,
        ),
        Center(
          child: Text(
            "AMAN",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
              'AMAN series of multinational exercises were started in 2007 with a view to promote regional cooperation and stability, greater interoperability and to display a united resolve against terrorism and crimes in maritime domain including Piracy. AMAN-21 is the 8th such exercise planned in 1st quarter 2021 at Karachi, Pakistan.'),
        ),
        //header text
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 200,
            height: 250,
            decoration: BoxDecoration(
              color: const Color(0xff7c94b6),
              image: const DecorationImage(
                image:
                    AssetImage('assets/images/admiral.jpg'),
                fit: BoxFit.cover,
              ),
              border: Border.all(
                color: Colors.black26,
                width: 8,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        //admiral photo
        Text(
          'Admiral Zafar Mahmood\nAbbasi NI(M)\nChief of the Naval Staff',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        RaisedButton(
          onPressed: (){
            SimpleAlertBox(context: context,title: 'Chief of the Naval Staff',infoMessage: 'Admiral Zafar Mahmood Abbasi NI(M) , Chief of the Naval Staff took charge on 07 October 2017. Admiral Zafar Mahmood Abbasi Nishan-i-Imtiaz (Military) joined Pakistan Navy on 13 January 1979 and undertook initial training at Britannia Royal Naval College Dartmouth, UK. The Admiral got commission in Operations Branch in June 1981 and won the coveted "SWORD OF HONOUR". During his distinguished career, the Admiral attained vast experience of Naval Operations, Training and Command assignments. His command appointments include Command of Surface ships, Commandant Pakistan Naval Academy, Commander 25th Destroyer Squadron, Command of Multi-National Combined Task Force 150 at HQ NAVCENT Bahrain, DG Pakistan Maritime Security Agency, Commander Coast, Commander Logistics and Commander Pakistan Fleet. Key staff appointments of the Admiral include Assistant Chief of Naval Staff (Plans), Chief Inspector (Navy), Deputy Chief of the Naval Staff (Operations) and Chief of the Staff at Naval Headquarters. The Admiral holds Masters degree in War Studies from National Defence University. He has also done Command & Staff Course from Royal Australian Navy Staff College.In recognition of his meritorious services, the Admiral has been awarded Nishan-i-Imtiaz (Military).',icon: Icons.info);
          },

          child: Text('More Details',style: TextStyle(color: Colors.white),),
        ),
        SizedBox(
          height: 20.0,
        ),
        new Container(
          decoration: new BoxDecoration(color: Colors.blueGrey.shade900),
          child: new TabBar(
            isScrollable: true,
            labelStyle: TextStyle(fontSize: 13.0 ),
            indicatorColor: Colors.white,
            controller: _tabController,
            tabs: [
              new Tab(
                text: 'AMAN-21',
              ),
              new Tab(
                text: 'AMAN-19',
              ),
              new Tab(
                text: 'AMAN-17',
              ),
              new Tab(
                text: 'AMAN-15',
              ),
              new Tab(
                text: 'AMAN-13',
              ),
              new Tab(
                text: 'AMAN-11',
              ),
              new Tab(
                text: 'AMAN-09',
              ),
              new Tab(
                text: 'AMAN-07',
              ),
            ],
          ),
        ),
        new Container(
          height: 250.0,
          child: new TabBarView(
            controller: _tabController,
            children: <Widget>[
              Container(
                color: Colors.blueGrey.shade900,
                child: new Card(
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: <Widget>[
                              Text(
                                'Exercise AMAN-21',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Expanded(
                            child: Flexible(
                              child: Text(
                                  'Exercise AMAN-21 has been scheduled in North Arabian Sea in 1st quarter of 2021. Navies of different Countries have been invited to participate. This is the 8th exercise of AMAN series. AMAN is an Urdu word meaning “PEACE” and slogan of AMAN exercise is “Together for Peace”.'),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
              Container(
                color: Colors.blueGrey.shade900,
                child: new Card(
                    child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Text(
                            'Exercise AMAN-19',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Flexible(
                        child: Text(
                          "Exercise AMAN-19 was conducted from 08 to 12 FEB 2019. 11 foreign country ships (Indonesia, Nigeria, Srilanka, China, Turkey, Malaysia, Poland, Italy, UK, USA), 15 EOD/SOF/Marines teams, 19 senior officers, 64 observers and 32 ambassadors/high commissioners/DAs/NAs/MAs (Total 115 observers/diplomates) other than PN & PMSA ships, aircrafts, SSG(N) teams and Pak Marines assets participated in the exercise.",
                      )),
                    ),
                  ],
                )),
              ),
              Container(
                color: Colors.blueGrey.shade900,
                child: new Card(
                    child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Text(
                            'Exercise AMAN-17',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Flexible(
                        child: Text(
                            'Exercise AMAN-17 was conducted from 10-14 Feb 2017 and 34 countries participated with naval assets and observers. Total 12 ships from Australia, China, Indonesia, Russia, Sri Lanka, Turkey, UK and USA took part in exercise. 07 x aircraft from Australia, China, Japan, Russia, Turkey & UK and 09 SOF/ EOD/ Marines teams from China, Indonesia, Malaysia, Maldives, Russia, Sri Lanka, Turkey and UK also participated during the exercise. 67 x observers of 34 countries participated in AMAN-17.'),
                      ),
                    ),
                  ],
                )),
              ),
              Container(
                color: Colors.blueGrey.shade900,
                child: new Card(
                    child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Text(
                            'Exercise AMAN-15',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Flexible(
                        child: Text(
                            'Exercise AMAN-15 was conducted in Feb 15. 13 ships, 02 aircraft, 14 SOF/EOD/Marines teams and more than 60 observers from 34 countries had confirmed their participation in the exercise. Only International Maritime Conference was conducted.'),
                      ),
                    ),
                  ],
                )),
              ),
              Container(
                color: Colors.blueGrey.shade900,
                child: new Card(
                    child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Text(
                            'Exercise AMAN-13',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Flexible(
                        child: Text(
                            'Exercise AMAN-13 was conducted from 4-8 March 2013. Navies of 29 countries participated with naval assets and observers. Total 12 ships from 10 different countries, 9 SOF/EOd teams from 6 different countries and 36 observers from 21 countries took part in exercise.'),
                      ),
                    ),
                  ],
                )),
              ),
              Container(
                color: Colors.blueGrey.shade900,
                child: new Card(
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: <Widget>[
                              Text(
                                'Exercise AMAN-11',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 10.0),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Flexible(
                              child: Text(
                                  'Exercise AMAN-11 was conducted from 8-12 March 2011 and 28 countries participated with naval assets and observers. Total 11 ships from Australia, China, France, Indonesia, Italy, Malaysia, Saudi Arabia and USA took part in exercise. Three aircraft from Australia & Japan and 03 SOF/EOD/Marines teams from China, Turkey and USA also participated during the exercise. Forty three observers of 26 countries participated in AMAN-11.'),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
              Container(
                color: Colors.blueGrey.shade900,
                child: new Card(
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: <Widget>[
                              Text(
                                'Exercise AMAN-09',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Flexible(
                            child: Text(
                                'Exercise AMAN-09 was held in March 2009. During this Exercise 23 ships, 13 Aircrafts and 9 SOF teams of Australia, Bangladesh, China, France, Japan, Malaysia, UK and Nigeria, Turkey and USA participated. Observers from 27 countries also attended the exercise'),
                          ),
                        ),
                      ],
                    )),
              ),
              Container(
                color: Colors.blueGrey.shade900,
                child: new Card(
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: <Widget>[
                              Text(
                                'Exercise AMAN-07',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Flexible(
                            child: Text(
                                'Exercise AMAN-07 was held in March 2007 which was a big success. During AMAN-07, 14 Ships of Bangladesh, China, France, Italy, Malaysia, UK and USA Navies participated. Besides, SOF/EOD teams from Bangladesh and Turkey also participated in SOF Exercises and 21 countries attended the Exercise as observer.'),
                          ),
                        ),
                      ],
                    )),
              )
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * .99,
          child: Card(
            shape: RoundedRectangleBorder(
              side: new BorderSide(color: Colors.blueGrey.shade900, width: 1),
              borderRadius: BorderRadius.circular(7.0),
            ),
            color: Colors.white,
            elevation: 10,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  child: const ListTile(

                    title: Text('Concept & Objectives',
                        style: TextStyle(color: Colors.black)),
                  ),
                ),
                // ignore: deprecated_member_use
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Flexible(
                    child: Text(
                        'The concept of AMAN revolves around information sharing, mutual understanding and identifying areas of common interests for participating navies with emphasis on maritime security operations, counter terrorism operations and humanitarian assistance operation. Based on this, the exercise seeks to develop and practice Response Tactics, Techniques, and procedures (RTTP) for maritime infrastructure, assets and forces against traditional and non-traditional threats.'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      side: new BorderSide(
                          color: Colors.blueGrey.shade900, width: 1),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    borderOnForeground: true,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Text("Concepts"),
                          Text('The concept of exercise is designed to:'),
                          RichText(
                            text: TextSpan(
                              text: '✓ ',
                              style: TextStyle(
                                  color: Colors.blueGrey.shade900,
                                  fontSize: 12),
                              children: <TextSpan>[
                                TextSpan(
                                    text:
                                        'Provide common forum for information sharing, mutual understanding and identifying areas of common interests.',
                                    style: TextStyle(color: Colors.black)),
                              ],
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              text: '✓ ',
                              style: TextStyle(
                                  color: Colors.blueGrey.shade900,
                                  fontSize: 12),
                              children: <TextSpan>[
                                TextSpan(
                                    text:
                                        'Develop and practice response tactics, techniques and procedures against asymmetric and traditional threats during sea phase of the exercise.',
                                    style: TextStyle(color: Colors.black)),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      side: new BorderSide(
                          color: Colors.blueGrey.shade900, width: 1),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    borderOnForeground: true,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Text("Objectives"),
                          Text('The concept of exercise is designed to:'),
                          RichText(
                            text: TextSpan(
                              text: '✓ ',
                              style: TextStyle(
                                  color: Colors.blueGrey.shade900,
                                  fontSize: 12),
                              children: <TextSpan>[
                                TextSpan(
                                    text:
                                        'Provide common forum for information sharing, mutual understanding and identifying areas of common interests.',
                                    style: TextStyle(color: Colors.black)),
                              ],
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              text: '✓ ',
                              style: TextStyle(
                                  color: Colors.blueGrey.shade900,
                                  fontSize: 12),
                              children: <TextSpan>[
                                TextSpan(
                                    text:
                                        'Develop and practice response tactics, techniques and procedures against asymmetric and traditional threats during sea phase of the exercise.',
                                    style: TextStyle(color: Colors.black)),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
//          Column(
//            mainAxisSize: MainAxisSize.min,
//            children: <Widget>[
//              Text(
//                'Gallery',
//                style: TextStyle(fontSize: 18),
//              ),
//              SizedBox(
//                height: 150.0,
//                child: ListView.builder(
//                  physics: ClampingScrollPhysics(),
//                  shrinkWrap: true,
//                  scrollDirection: Axis.horizontal,
//                  itemCount: getgalerrieslist.length,
//                  itemBuilder: (BuildContext context, int index) => Padding(
//                    padding: EdgeInsets.only(left:15,top: 15 ),
//                    child: Container(
//                      width: 200,
//                      child: Card(
//                        shape: RoundedRectangleBorder(
//                          side: new BorderSide(color: Colors.blue, width: .5),
//                          borderRadius: BorderRadius.circular(5.0),
//                        ),
//                        child: CachedNetworkImage(
//                          placeholder: (context, url) =>
//                          const CircularProgressIndicator(),
//                          imageUrl: getgalerrieslist[index],
//                        ),
//                      ),
//
//                    ),
//                  ),
//                ),
//              ),
//
//            ],
//          ),
        Container(
          margin: EdgeInsets.only(bottom: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Important Links',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(
                height: 150.0,
                child: ListView.builder(

                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: iconslist.length,
                  itemBuilder: (BuildContext context, int index) => Padding(
                    padding: EdgeInsets.only(left: 15, top: 15),
                    child: GestureDetector(
                      onTap: () {
                        _launchURL(getlinklist[index].value);
                      },
                      child: Container(

                        width: 200,
                        child: Card(
                            shape: RoundedRectangleBorder(
                              side: new BorderSide(
                                  color: Colors.blueGrey.shade900, width: 1),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            elevation: 10,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: 50,
                                  child: iconslist[index],
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  height: 100,
                                  width: .5,
                                  color: Colors.blueGrey.shade900,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Center(
                                  child: Text(getlinklist[index].key),
                                )
                              ],
                            )),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
//
//          Container(
//      width: 400,
//      height: 400,
//
//        child: Image.network('https://maps.googleapis.com/maps/api/staticmap?center=31.565%2C74.304&language=en&size=640x256&zoom=15&scale=1&channel=olx-latam-ar-web-dev&key=AIzaSyAChxbDof4fywIkC6U-7MCgXBpUp4t2DiA&signature=c-SAJkUdvOWkyl627rgM5nTwI5I=',
//            fit: BoxFit.fill),
//
//    ),
      ]),
    );
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void getdata() async {
    var response = await http.get('http://sarosh-001-site1.itempurl.com/filepaths/slider');

    if (response.statusCode == 401){
      print('error');
    }
    else if(response.statusCode == 200){
      var responseJson = json.decode(response.body);
      for (var u in responseJson) {
        getlinklistforslider.add((u['path'].toString()));
      }
      setState(() {
        check = false;
      });


    }


  }
}

// One entry in the multilevel list displayed by this app.
class Entry {
  Entry(this.title, [this.children = const <Entry>[]]);

  final String title;
  final List<Entry> children;
}

// The entire multilevel list displayed by this app.
final List<Entry> data = <Entry>[
  Entry(
    'Exercise',
    <Entry>[
      Entry(
        'Activities',
        <Entry>[
          Entry('Harbour Phase'),
          Entry('Sea Phase'),
        ],
      ),
      Entry(
        'Events',
        <Entry>[
          Entry('Opening Cermony'),
          Entry('Reception Dinner'),
          Entry('IMC'),
          Entry('Band Display & CT Demo'),
          Entry('Food Gala & Cultural Show'),
          Entry('IFR(Internal Fleet Review)'),
        ],
      ),
      Entry(
        'Scedule ',
        <Entry>[
          Entry('Events'),
          Entry('Date & time'),
        ],
      ),
    ],
  ),
  Entry(
    'Chapter B',
    <Entry>[
      Entry('Section B0'),
      Entry('Section B1'),
    ],
  ),
  Entry(
    'Chapter C',
    <Entry>[
      Entry('Section C0'),
      Entry('Section C1'),
      Entry(
        'Section C2',
        <Entry>[
          Entry('Item C2.0'),
          Entry('Item C2.1'),
          Entry('Item C2.2'),
          Entry('Item C2.3'),
        ],
      ),
    ],
  ),
];

// Displays one Entry. If the entry has children then it's displayed
// with an ExpansionTile.
class EntryItem extends StatelessWidget {
  const EntryItem(this.entry);

  final Entry entry;

  Widget _buildTiles(Entry root) {
    if (root.children.isEmpty) return ListTile(title: Text(root.title));
    return ExpansionTile(
      key: PageStorageKey<Entry>(root),
      title: Text(root.title),
      children: root.children.map(_buildTiles).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(entry);
  }
}
