// File: lib/screens/bug_result_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/bug_response.dart';
import '../utils/app_colors.dart';
import '../widgets/custom_button.dart';

class BugResultScreen extends StatelessWidget {
  final BugResponse result;
  final String originalCode;

  const BugResultScreen({
    Key? key,
    required this.result,
    required this.originalCode,
  }) : super(key: key);

  void _copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Copied fix to clipboard!'), backgroundColor: AppColors.primaryRed),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: const Text('Bug Analysis Result', style: TextStyle(color: AppColors.textMain, fontSize: 18)),
        iconTheme: const IconThemeData(color: AppColors.textMain),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Status Header Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.cardColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.primaryRed.withOpacity(0.4)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.bug_report, color: AppColors.primaryRed, size: 24),
                    const SizedBox(width: 12),
                    Text(
                      result.hasBugs ? 'Potential Bug Found' : 'Code Looks Clean!',
                      style: const TextStyle(color: AppColors.textMain, fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Problem Section
              const Text('Problem', style: TextStyle(color: AppColors.primaryRed, fontWeight: FontWeight.bold, fontSize: 15)),
              const SizedBox(height: 6),
              Text(result.problem, style: const TextStyle(color: AppColors.textMain, fontSize: 14)),
              const SizedBox(height: 16),

              // Why it's a problem
              const Text('Why?', style: TextStyle(color: AppColors.textMain, fontWeight: FontWeight.bold, fontSize: 15)),
              const SizedBox(height: 6),
              Text(result.whyItIsProblem, style: const TextStyle(color: AppColors.textSecondary, fontSize: 14, height: 1.4)),
              const SizedBox(height: 16),

              // Possible Fix Code Block
              const Text('Possible Fix', style: TextStyle(color: AppColors.primaryGreen, fontWeight: FontWeight.bold, fontSize: 15)),
              const SizedBox(height: 6),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.cardColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.withOpacity(0.2)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        result.possibleFix,
                        style: const TextStyle(color: AppColors.textMain, fontFamily: 'monospace', fontSize: 13),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.copy, size: 18, color: AppColors.textSecondary),
                      onPressed: () => _copyToClipboard(context, result.possibleFix),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Explanation of Fix
              const Text('Explanation', style: TextStyle(color: AppColors.textMain, fontWeight: FontWeight.bold, fontSize: 15)),
              const SizedBox(height: 6),
              Text(result.explanation, style: const TextStyle(color: AppColors.textSecondary, fontSize: 14, height: 1.4)),
              const SizedBox(height: 30),

              // Bottom Actions
              CustomButton(
                text: 'Copy Fix',
                icon: Icons.copy,
                backgroundColor: AppColors.primaryRed,
                onPressed: () => _copyToClipboard(context, result.possibleFix),
              ),
            ],
          ),
        ),
      ),
    );
  }
}