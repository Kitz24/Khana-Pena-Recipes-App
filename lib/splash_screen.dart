import 'package:flutter/material.dart';
import 'dart:async';

import 'package:khana_peena_recipes/council_of_pages.dart'; // Import for Timer

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  final splashDelay = Duration(seconds: 2); // Change this to your desired delay

  @override
  void initState() {
    super.initState();
    Future.delayed(splashDelay, _navigateToHome); // Call _navigateToHome after delay

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FadeTransition(
          opacity: _fadeInAnimation(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Welcome to KhaanaPeena"),
            ],
          ),
        ),
      ),
    );
  }

  Animation<double> _fadeInAnimation() {
    final animationController = AnimationController(
      vsync: (this), // Anonymous function
      duration: Duration(milliseconds: 1000), // Adjust fade-in duration
    )..forward();
    return Tween<double>(begin: 0.0, end: 1.0).animate(animationController);
  }

  void _navigateToHome() async {
    await Future.delayed(splashDelay); // Wait for the delay
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => CouncilOfPages()), // Replace with your home screen widget
    );
  }
}
