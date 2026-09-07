// File: lib/screens/convert_result_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/convert_response.dart';
import '../utils/app_colors.dart';
import '../widgets/custom_button.dart';

class ConvertResultScreen extends StatelessWidget {
  final ConvertResponse result;
  final String targetLanguage;

  const ConvertResultScreen({
    Key? key,
    required this.result,
    required this.targetLanguage,
  }) : super(key: key);

  void _copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Copied converted code!'), backgroundColor: AppColors.primaryBlue),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text('Converted to $targetLanguage', style: const TextStyle(color: AppColors.textMain, fontSize: 18)),
        iconTheme: const IconThemeData(color: AppColors.textMain),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Translated Code ($targetLanguage)', style: const TextStyle(color: AppColors.primaryBlue, fontWeight: FontWeight.bold, fontSize: 15)),
                  IconButton(
                    icon: const Icon(Icons.copy, size: 18, color: AppColors.textSecondary),
                    onPressed: () => _copyToClipboard(context, result.convertedCode),
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
                  border: Border.all(color: AppColors.primaryBlue.withOpacity(0.3)),
                ),
                child: Text(
                  result.convertedCode,
                  style: const TextStyle(color: AppColors.textMain, fontFamily: 'monospace', fontSize: 13),
                ),
              ),
              const SizedBox(height: 20),
              const Text('Key Differences & Notes', style: TextStyle(color: AppColors.textMain, fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 10),
              ...result.keyDifferences.map((diff) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.swap_horiz, color: AppColors.primaryBlue, size: 18),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          diff,
                          style: const TextStyle(color: AppColors.textSecondary, fontSize: 14, height: 1.3),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
              const SizedBox(height: 30),
              CustomButton(
                text: 'Copy Converted Code',
                icon: Icons.copy,
                backgroundColor: AppColors.primaryBlue,
                onPressed: () => _copyToClipboard(context, result.convertedCode),
              ),
            ],
          ),
        ),
      ),
    );
  }
}