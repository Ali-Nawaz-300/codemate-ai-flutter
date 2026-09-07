// File: lib/screens/improve_result_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/improve_response.dart';
import '../utils/app_colors.dart';
import '../widgets/custom_button.dart';

class ImproveResultScreen extends StatelessWidget {
  final ImproveResponse result;
  final String originalCode;

  const ImproveResultScreen({
    Key? key,
    required this.result,
    required this.originalCode,
  }) : super(key: key);

  void _copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Copied improved code!'), backgroundColor: AppColors.primaryGreen),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: const Text('Improved Result', style: TextStyle(color: AppColors.textMain, fontSize: 18)),
        iconTheme: const IconThemeData(color: AppColors.textMain),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Improved Code Box
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Optimized Code', style: TextStyle(color: AppColors.primaryGreen, fontWeight: FontWeight.bold, fontSize: 15)),
                  IconButton(
                    icon: const Icon(Icons.copy, size: 18, color: AppColors.textSecondary),
                    onPressed: () => _copyToClipboard(context, result.improvedCode),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.cardColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.primaryGreen.withOpacity(0.3)),
                ),
                child: Text(
                  result.improvedCode,
                  style: const TextStyle(color: AppColors.textMain, fontFamily: 'monospace', fontSize: 13),
                ),
              ),
              const SizedBox(height: 20),

              // Improvements List Section
              const Text('Improvements Made', style: TextStyle(color: AppColors.textMain, fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 10),
              ...result.improvements.map((improvement) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.check_circle, color: AppColors.primaryGreen, size: 18),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          improvement,
                          style: const TextStyle(color: AppColors.textSecondary, fontSize: 14, height: 1.3),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
              const SizedBox(height: 30),

              // Bottom Actions
              CustomButton(
                text: 'Copy Optimized Code',
                icon: Icons.copy,
                backgroundColor: AppColors.primaryGreen,
                onPressed: () => _copyToClipboard(context, result.improvedCode),
              ),
            ],
          ),
        ),
      ),
    );
  }
}