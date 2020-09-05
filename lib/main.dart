// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:animated_splash/animated_splash.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_indicator/page_indicator.dart';
import 'Views/Page1.dart';

void main() {
  Function duringSplash = () {
    print('Something background process');
    int a = 123 + 23;
    print(a);

    if (a > 100)
      return 1;
    else
      return 2;
  };
  Map<int, Widget> op = {1: MyApp()};

  runApp(MaterialApp(
    home: AnimatedSplash(
      imagePath: 'assets/images/anchor.png',
      home: MyApp(),
      customFunction: duringSplash,
      duration: 2500,
      type: AnimatedSplashType.BackgroundProcess,
      outputAndHome: op,
    ),
  ));
}

class MyApp extends StatefulWidget {
  Mainpage createState() => Mainpage();
}

class Mainpage extends State<MyApp> {
  PageController _pageController = PageController();
  double currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                colorFilter: ColorFilter.mode(
                    Colors.blueGrey.shade900.withOpacity(0.5), BlendMode.color),
                image: AssetImage('assets/images/background.jpeg'),
                fit: BoxFit.cover)),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            children: <Widget>[

              Container(

                color: Colors.black54,
                child: ListTile(
                  leading: CachedNetworkImage(
                    imageUrl: "https://aman.paknavy.gov.pk/images/logo.png",
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                  title: Text(
                    'EXERCISE AMAN 2019',

                    style: GoogleFonts.berkshireSwash(
                      textStyle: TextStyle(color: Colors.white, letterSpacing: .5,fontWeight: FontWeight.bold,fontSize: 20),
                    )
                  ),
                  subtitle: Text('Together for Peace',style: TextStyle(color: Colors.white),),
                ),
              ),

              Expanded(
                child: PageIndicatorContainer(
                  align: IndicatorAlign.bottom,
                  length: 4,
                  indicatorSpace: 10.0,
                  child: PageView(
                    controller: _pageController,
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      page1(),
                      page1(),
                      page1(),
                      page1(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    _pageController.addListener(() {
      setState(() {
        currentPage = _pageController.page;
      });
    });
    super.initState();
  }
}
//
//Container(height:double.infinity,child: Image.asset('assets/images/background.jpeg',fit: BoxFit.cover)),
//child: Column(
//children: <Widget>[
//PageIndicatorContainer(
//align: IndicatorAlign.bottom,
//length: 4,
//indicatorSpace: 10.0,
//child: PageView(
//controller: _pageController,
//scrollDirection: Axis.horizontal,
//children: <Widget>[
//page1(),
//page1(),
//page1(),
//page1(),
//],
//),
//)
//],
//),
