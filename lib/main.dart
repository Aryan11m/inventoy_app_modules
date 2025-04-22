// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:inventory_app/login1.dart';
import 'package:get/get.dart';
import 'package:inventory_app/page.dart';
import 'package:inventory_app/splashscreen.dart';
import 'package:inventory_app/star.dart';

dynamic height, width;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return GetMaterialApp(
      // initialRoute: SplashScreen(),
      getPages: [
        GetPage(name: '/Home', page: () => MyHomePage()),
        GetPage(name: '/Login', page: () => LoginPage()),
        GetPage(name: '/Star', page: () => StarPage()),
      ],
      title: 'Login Page',
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
