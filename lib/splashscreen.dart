import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:inventory_app/QRCode/company_code.dart';
import 'package:inventory_app/QRCode/homepage.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      checkLoginStatus();
    });
  }

  void checkLoginStatus() async {
    // Get the auth box for checking login status
    final authBox = Hive.box('authBox');

    // Check if user is logged in
    final isLoggedIn = authBox.get('isLoggedIn', defaultValue: false);

    if (isLoggedIn) {
      // User is logged in, navigate to home page
      Get.off(() => const Scanner());
    } else {
      // User is not logged in, navigate to login page
      Get.off(() => const CompanyCode());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue,
        child: Center(
          child: AnimatedTextKit(
            animatedTexts: [
              FadeAnimatedText(
                'Invento',
                textStyle: const TextStyle(
                  backgroundColor: Colors.blue,
                  color: Colors.white,
                  fontSize: 48.0,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  shadows: [
                    Shadow(
                      offset: Offset(2.0, 2.0),
                      blurRadius: 3.0,
                      color: Color.fromARGB(255, 61, 60, 60),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
