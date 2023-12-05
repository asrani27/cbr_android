import 'dart:io';

import 'package:cbr_android/screen/login.dart';
import 'package:cbr_android/screen/splash.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  //verified api
  HttpOverrides.global = MyHttpOverrides();

  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    getPages: [
      GetPage(name: '/', page: () => MyApp()),
      GetPage(name: '/login', page: () => login()),
    ],
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Center(
        child: splash(),
      ),
    );
  }
}
