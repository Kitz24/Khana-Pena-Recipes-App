import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:async';

import 'package:khana_peena_recipes/council_of_pages.dart'; // Import for Timer

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  final splashDelay = Duration(seconds: 2); // Change this to your desired delay
  late AnimationController _animationController;
  late Animation<double> _fadeInAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500), // Adjust fade-in duration
    );
    _fadeInAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _animationController.forward();

    Future.delayed(splashDelay, _navigateToHome); // Call _navigateToHome after delay
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: Color(0xFFbbde9e), // Set the background color here
        child: Center(
          child: FadeTransition(
            opacity: _fadeInAnimation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Icon(
                  Icons.security,
                  size: 100,
                  color: Colors.redAccent,
                ),
                SizedBox(height: 20), // Space between image and text
                Text(
                  "Welcome to     \n        All-in-One Security     \n    Loading...",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown,
                    fontFamily: "Bocchi"
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => CouncilOfPages()), // Replace with your home screen widget
    );
  }
}
