import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:inventory_app/QRCode/company_code.dart';
// import 'package:inventory_app/QRCode/homepage.dart';
// import 'package:animated_text_kit/animated_text_kit.dart';
// import 'package:inventory_app/Status.dart';
import 'package:inventory_app/page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat(reverse: true);
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  );

  @override
  void initState() {
    super.initState();

    Timer(const Duration(milliseconds: 2700), () {
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
      Get.off(() => MyHomePage());
    } else {
      // User is not logged in, navigate to login page
      Get.off(() => const CompanyCode());
    }
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose the animation controller first
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue,
        child: Center(
          child: ScaleTransition(
            scale: _animation,
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Invento',
                style: const TextStyle(
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
            ),
          ),
          // child: AnimatedTextKit(
          //   animatedTexts: [
          //     FadeAnimatedText(
          //       'Invento',
          //       textStyle: const TextStyle(
          //         backgroundColor: Colors.blue,
          //         color: Colors.white,
          //         fontSize: 48.0,
          //         fontWeight: FontWeight.bold,
          //         fontStyle: FontStyle.italic,
          //         shadows: [
          //           Shadow(
          //             offset: Offset(2.0, 2.0),
          //             blurRadius: 3.0,
          //             color: Color.fromARGB(255, 61, 60, 60),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ],
          // ),
        ),
      ),
    );
  }
}
