// File: lib/screens/settings_screen.dart

import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../services/history_service.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  void _clearHistory(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.cardColor,
        title: const Text('Clear History?', style: TextStyle(color: AppColors.textMain)),
        content: const Text('This will permanently delete all your saved AI code analysis results.', style: TextStyle(color: AppColors.textSecondary)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: AppColors.textSecondary)),
          ),
          TextButton(
            onPressed: () async {
              await HistoryService.clearHistory();
              if (!context.mounted) return;
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('All history cleared!'), backgroundColor: AppColors.primaryRed),
              );
            },
            child: const Text('Delete', style: TextStyle(color: AppColors.primaryRed)),
          ),
        ],
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.cardColor,
        title: const Text('About CodeMate AI', style: TextStyle(color: AppColors.textMain)),
        content: const Text(
          'Version 1.0.0\n\nCodeMate AI is a focused developer assistant built to demonstrate cross-platform UI development, asynchronous REST API integration, and complex JSON data parsing.',
          style: TextStyle(color: AppColors.textSecondary, height: 1.4),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close', style: TextStyle(color: AppColors.primaryBlue)),
          ),
        ],
      ),
    );
  }

  void _showTechStackDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.cardColor,
        title: const Text('Tech Stack', style: TextStyle(color: AppColors.textMain)),
        content: const Text(
          '• UI framework: Flutter & Dart\n• AI Engine: Google Gemini 3.6 Flash\n• Networking: HTTP REST API\n• Local Storage: SharedPreferences\n• State Management: Stateful Widgets',
          style: TextStyle(color: AppColors.textSecondary, height: 1.5),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close', style: TextStyle(color: AppColors.primaryGreen)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: const Text('Settings', style: TextStyle(color: AppColors.textMain, fontSize: 18)),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            _buildSectionHeader('Data & Privacy'),
            _buildSettingCard(
              icon: Icons.delete_forever,
              iconColor: AppColors.primaryRed,
              title: 'Clear History',
              subtitle: 'Remove all saved AI requests from device',
              onTap: () => _clearHistory(context),
            ),
            const SizedBox(height: 24),

            _buildSectionHeader('About App'),
            _buildSettingCard(
              icon: Icons.info_outline,
              iconColor: AppColors.primaryBlue,
              title: 'CodeMate AI',
              subtitle: 'Version 1.0.0',
              onTap: () => _showAboutDialog(context),
            ),
            _buildSettingCard(
              icon: Icons.code,
              iconColor: AppColors.primaryGreen,
              title: 'Tech Stack',
              subtitle: 'Powered by Google Gemini & Flutter',
              onTap: () => _showTechStackDialog(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, left: 4),
      child: Text(
        title,
        style: const TextStyle(color: AppColors.textMain, fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }

  Widget _buildSettingCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    Widget? trailing,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: iconColor, size: 22),
        ),
        title: Text(title, style: const TextStyle(color: AppColors.textMain, fontWeight: FontWeight.bold, fontSize: 15)),
        subtitle: Text(subtitle, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
        trailing: trailing ?? const Icon(Icons.chevron_right, color: AppColors.textSecondary),
        onTap: onTap,
      ),
    );
  }
}