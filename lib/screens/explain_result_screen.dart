// File: lib/screens/explain_result_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/explain_response.dart';
import '../utils/app_colors.dart';
import '../widgets/custom_button.dart';

class ExplainResultScreen extends StatelessWidget {
  final ExplainResponse result;
  final String originalCode;
  final String language;

  const ExplainResultScreen({
    Key? key,
    required this.result,
    required this.originalCode,
    required this.language,
  }) : super(key: key);

  void _copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Copied to clipboard!'),
        backgroundColor: AppColors.primaryPurple,
        duration: Duration(seconds: 2),
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
        title: const Text('Explanation Result', style: TextStyle(color: AppColors.textMain, fontSize: 18)),
        iconTheme: const IconThemeData(color: AppColors.textMain),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined),
            onPressed: () {
              // Share placeholder
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Summary Section
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.cardColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.primaryPurple.withOpacity(0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.lightbulb, color: AppColors.primaryPurple, size: 20),
                        SizedBox(width: 8),
                        Text('Simple Explanation', style: TextStyle(color: AppColors.textMain, fontWeight: FontWeight.bold, fontSize: 16)),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      result.summary,
                      style: const TextStyle(color: AppColors.textSecondary, fontSize: 14, height: 1.4),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Step-by-Step Explanation Section
              const Text('Detailed Breakdown', style: TextStyle(color: AppColors.textMain, fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.cardColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  result.explanation,
                  style: const TextStyle(color: AppColors.textMain, fontSize: 14, height: 1.5),
                ),
              ),
              const SizedBox(height: 20),

              // Important Concepts Tags
              const Text('Key Concepts', style: TextStyle(color: AppColors.textMain, fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: result.importantConcepts.map((concept) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.primaryPurple.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.primaryPurple.withOpacity(0.4)),
                    ),
                    child: Text(
                      concept,
                      style: const TextStyle(color: AppColors.primaryPurple, fontSize: 12, fontWeight: FontWeight.w500),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 30),

              // Bottom Action Buttons
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      text: 'Copy Result',
                      icon: Icons.copy,
                      isOutlined: true,
                      onPressed: () => _copyToClipboard(context, '${result.summary}\n\n${result.explanation}'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: CustomButton(
                      text: 'Share',
                      icon: Icons.share,
                      backgroundColor: AppColors.primaryPurple,
                      onPressed: () {
                        // Action handle
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}