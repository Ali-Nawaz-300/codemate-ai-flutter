// File: lib/screens/splash_screen.dart

import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Simulate a loading delay of 2.5 seconds
    Future.delayed(const Duration(milliseconds: 2500), () {
      // Navigate to Home Screen and remove Splash Screen from history
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Mocking the logo from your design using icons and text
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('{', style: TextStyle(fontSize: 80, color: AppColors.primaryPurple, fontWeight: FontWeight.w300)),
                const Icon(Icons.smart_toy, size: 70, color: AppColors.primaryPurple),
                const Text('}', style: TextStyle(fontSize: 80, color: AppColors.primaryPurple, fontWeight: FontWeight.w300)),
              ],
            ),
            const SizedBox(height: 20),

            // App Title
            RichText(
              text: const TextSpan(
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: AppColors.textMain),
                children: [
                  TextSpan(text: 'CodeMate '),
                  TextSpan(text: 'AI', style: TextStyle(color: AppColors.primaryPurple)),
                ],
              ),
            ),
            const SizedBox(height: 10),

            // Subtitle
            const Text(
              'AI Powered Code Analysis &\nLearning Assistant',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: AppColors.textSecondary,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 60),

            // Loading Bar matching your design
            SizedBox(
              width: 200,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: const LinearProgressIndicator(
                  color: AppColors.primaryPurple,
                  backgroundColor: AppColors.cardColor,
                  minHeight: 6,
                ),
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              'Loading...',
              style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}