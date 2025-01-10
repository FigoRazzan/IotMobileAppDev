import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../screens/home_dashboard.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    // Initialize animation controller
    _controller = AnimationController(vsync: this);

    // Set timer for navigation after 5 seconds (same as original code)
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Changed to match your desired background
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Lottie animation
            SizedBox(
              height: 450, // Match your desired splashIconSize
              child: Lottie.asset(
                'assets/lottie/Animation - splashscreen.json',
                controller: _controller,
                onLoaded: (composition) {
                  _controller.duration = composition.duration * 2 ~/ 3;
                  _controller.repeat();
                },
              ),
            ),
            // Original text elements if you want to keep them
            const Text(
              'SMART Room Monitoring',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors
                    .white, // Changed to white for better visibility on black
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
