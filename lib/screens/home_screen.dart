// File: lib/screens/home_screen.dart

import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../widgets/feature_card.dart';
import 'explain_code_screen.dart';
import 'find_bugs_screen.dart';
import 'improve_code_screen.dart';
import 'convert_code_screen.dart';
import 'history_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  // This widget holds the main Home Screen UI (the 4 cards)
  Widget _buildHomeView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: const TextSpan(
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.textMain),
                  children: [
                    TextSpan(text: 'CodeMate '),
                    TextSpan(text: 'AI', style: TextStyle(color: AppColors.primaryPurple)),
                  ],
                ),
              ),
              const Icon(Icons.workspace_premium, color: Colors.amber),
            ],
          ),
          const SizedBox(height: 5),
          const Text('Your AI Coding Assistant', style: TextStyle(color: AppColors.textSecondary, fontSize: 14)),
          const SizedBox(height: 30),
          Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                FeatureCard(
                  title: 'Explain Code',
                  subtitle: 'Understand your code in simple words',
                  icon: Icons.lightbulb_outline,
                  iconBackgroundColor: AppColors.primaryPurple,
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ExplainCodeScreen())),
                ),
                FeatureCard(
                  title: 'Find Bugs',
                  subtitle: 'Detect issues and potential problems',
                  icon: Icons.bug_report_outlined,
                  iconBackgroundColor: AppColors.primaryRed,
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const FindBugsScreen())),
                ),
                FeatureCard(
                  title: 'Improve Code',
                  subtitle: 'Get optimized and cleaner code',
                  icon: Icons.auto_fix_high,
                  iconBackgroundColor: AppColors.primaryGreen,
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ImproveCodeScreen())),
                ),
                FeatureCard(
                  title: 'Convert Code',
                  subtitle: 'Convert code between programming languages',
                  icon: Icons.transform,
                  iconBackgroundColor: AppColors.primaryBlue,
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ConvertCodeScreen())),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // We use a list of widgets to easily switch the screen body
    final List<Widget> screens = [
      _buildHomeView(),
      const HistoryScreen(),
      const SettingsScreen(),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: screens[_currentIndex], // Shows the screen based on the selected tab
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.cardColor,
        selectedItemColor: AppColors.primaryPurple,
        unselectedItemColor: AppColors.textSecondary,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Updates the UI when a tab is tapped
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}