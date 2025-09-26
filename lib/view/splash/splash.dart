import 'package:app_scrip/utils/colors.dart';
import 'package:app_scrip/utils/user_preferences.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  double _iconOpacity = 0.0;
  double _iconScale = 0.5;
  double _textOpacity = 0.0;

  @override
  void initState() {
    super.initState();

    // Animate icon and text
    Timer(const Duration(milliseconds: 300), () {
      setState(() {
        _iconOpacity = 1.0;
        _iconScale = 1.0;
      });
    });

    Timer(const Duration(milliseconds: 800), () {
      setState(() {
        _textOpacity = 1.0;
      });
    });

    // Navigate after 3 seconds
    Timer(const Duration(seconds: 3), () {
      navigate();
      // context.pushReplacement("/tasklist");
    });
  }

  Future<void> navigate() async {
    final token = await UserPreferences.getToken();

    if (mounted) {
      if (token.isEmpty) {
        context.pushReplacement("/register");
      } else {
        context.pushReplacement("/tasklist");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedOpacity(
              opacity: _iconOpacity,
              duration: const Duration(seconds: 1),
              child: AnimatedScale(
                scale: _iconScale,
                duration: const Duration(seconds: 1),
                curve: Curves.easeOutBack,
                child: const Icon(Icons.check_circle, size: 100, color: blue),
              ),
            ),
            const SizedBox(height: 20),
            AnimatedOpacity(
              opacity: _textOpacity,
              duration: const Duration(seconds: 1),
              child: const Text(
                "My To-Do",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: black,
                ),
              ),
            ),
            const SizedBox(height: 10),
            AnimatedOpacity(
              opacity: _textOpacity,
              duration: const Duration(seconds: 1),
              child: const Text(
                "Organize your tasks easily",
                style: TextStyle(fontSize: 16, color: grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
