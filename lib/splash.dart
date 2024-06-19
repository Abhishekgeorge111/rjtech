import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rjtech/number.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // static const String animationPath = 'assets/animations/kartify.json';
  static const int delaySeconds = 7;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: delaySeconds), _navigateToHome);
  }

  void _navigateToHome() {
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          // Lottie.network('https://lottie.host/88167c06-be42-40ed-a6b4-8bfceadec7f1/ksEsYqb7wt.lottie',
          Lottie.asset(
            'assets/taxi.json',
            height: screenSize.height * 0.30,
            width: screenSize.width * 0.80,
          ),
          const SizedBox(
            height: 60,
          ),
          const Text(
            'E Taxi',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
        ]),
      ),
    );
  }
}
