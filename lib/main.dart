// File: lib/main.dart

import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'utils/app_colors.dart';

void main() {
  runApp(const CodeMateApp());
}

class CodeMateApp extends StatelessWidget {
  const CodeMateApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CodeMate AI',
      debugShowCheckedModeBanner: false, // Removes the debug banner
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.background,
        brightness: Brightness.dark,
        useMaterial3: true,
        fontFamily: 'Inter', // We can adjust the font later, standard sans-serif for now
      ),
      home: const SplashScreen(),
    );
  }
}