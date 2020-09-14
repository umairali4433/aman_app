import 'package:aman_app/model/getlink.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class speakers extends StatefulWidget {
  @override
  _speakersState createState() => _speakersState();
}

class _speakersState extends State<speakers> {
  List<getlink> getleaderslsit =  [];
  @override
  void initState() {
    getleaderslsit.add(getlink('COMMANDER NEHMAN ZAFAR PN','DEPUTY DIRECTOR (EX AMAN)'));
    getleaderslsit.add(getlink('CAPTAIN KHYBER ZAMAN TI(M) PN','DIRECTOR NAVAL OPERATIONS'));

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Speakers'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Column(
            children: <Widget>[
              Card(
                child: GestureDetector(
                  onTap: (){
                  },
                  child: ListTile(
                    title: Text(
                      getleaderslsit[index].key,
                      style: TextStyle(color: Colors.black),
                    ),
                    subtitle: Text(getleaderslsit[index].value,
                        style: TextStyle(color: Colors.black)),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://aman.paknavy.gov.pk/images/logo.png'),
                    ),
                  ),
                ),
              ),
              Divider(
                color: Colors.white.withOpacity(.2),
                height: 0.5,

              )
            ],
          );
        },
        itemCount: getleaderslsit.length,
      ),
    );
  }
}
