import 'dart:async';

import 'package:cbr_android/api/bapok.dart';
import 'package:cbr_android/screen/dashboard.dart';
import 'package:cbr_android/screen/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class splash extends StatefulWidget {
  const splash({super.key});

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {
  var bjmpintar;
  bool ActiveConnection = false;
  String T = "";

  Future haveToken() async {
    var response = await PostDataService().hasToken();
    if (response == null) {
      Get.offAll(() => login());
    } else {
      Get.offAll(() => dashboard());
    }
    print(['hasil', response]);
  }

  Future checkToken() async {
    //var response = await PostDataService().checkToken();

    // if (response == 401) {
    Get.offAll(() => login());
    // } else {
    // print('kedashboard');
    // Get.offAll(() => dashboard());

    //}
  }

  @override
  void initState() {
    Future.delayed(Duration(seconds: 2), () {
      Get.offAll(() => login());
      //Get.offAll(() => dashboard());
    });
    //checkToken();

    //checkPermission(Permission.location, context);
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: null,
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  stops: [
                0.2,
                0.5,
                0.8,
                0.6,
              ],
                  colors: [
                Colors.purple[50]!,
                Colors.purple[100]!,
                Colors.purple[200]!,
                Colors.purple[300]!
              ])),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Center(
                  child: Image.asset(
                    'assets/images/cbr.png',
                    width: 160,
                  ),
                ),
              ),
              SpinKitFadingCircle(
                color: Colors.purpleAccent,
                size: 30,
              ),
            ],
          ),
        ));
  }
}
