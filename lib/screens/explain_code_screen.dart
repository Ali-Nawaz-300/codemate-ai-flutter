// File: lib/screens/explain_code_screen.dart

import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../widgets/custom_button.dart';
import '../services/api_service.dart';
import 'explain_result_screen.dart';
import '../services/history_service.dart';

class ExplainCodeScreen extends StatefulWidget {
  const ExplainCodeScreen({Key? key}) : super(key: key);

  @override
  State<ExplainCodeScreen> createState() => _ExplainCodeScreenState();
}

class _ExplainCodeScreenState extends State<ExplainCodeScreen> {
  final TextEditingController _codeController = TextEditingController();
  String _selectedLanguage = 'Python';
  String _selectedLevel = 'Beginner';
  bool _isLoading = false;

  final List<String> _languages = ['Python', 'Dart', 'Swift', 'JavaScript', 'Java', 'C++', 'PHP'];
  final List<String> _levels = ['Beginner', 'Intermediate', 'Advanced'];

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  void _insertExampleCode() {
    setState(() {
      _codeController.text = '''for case in cases:
    if case.status == "pending":
        print(case)''';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: const Text('Explain Code', style: TextStyle(color: AppColors.textMain, fontSize: 18)),
        iconTheme: const IconThemeData(color: AppColors.textMain),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {}, // History placeholder
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Language Dropdown
              const Text('Programming Language', style: TextStyle(color: AppColors.textMain, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: AppColors.cardColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedLanguage,
                    isExpanded: true,
                    dropdownColor: AppColors.cardColor,
                    style: const TextStyle(color: AppColors.textMain),
                    items: _languages.map((String lang) {
                      return DropdownMenuItem<String>(value: lang, child: Text(lang));
                    }).toList(),
                    onChanged: (String? newValue) {
                      if (newValue != null) setState(() => _selectedLanguage = newValue);
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Explanation Level Selector
              const Text('Explanation Level', style: TextStyle(color: AppColors.textMain, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Row(
                children: _levels.map((level) {
                  bool isSelected = _selectedLevel == level;
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedLevel = level),
                      child: Container(
                        margin: const EdgeInsets.only(right: 8),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: isSelected ? AppColors.primaryPurple : AppColors.cardColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            level,
                            style: TextStyle(
                              color: isSelected ? Colors.white : AppColors.textSecondary,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),

              // Code Input Area
              const Text('Your Code', style: TextStyle(color: AppColors.textMain, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.cardColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    controller: _codeController,
                    maxLines: null,
                    expands: true,
                    style: const TextStyle(color: AppColors.textMain, fontFamily: 'monospace', fontSize: 14),
                    decoration: const InputDecoration(
                      hintText: 'Paste your code here...',
                      hintStyle: TextStyle(color: AppColors.textSecondary),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(16),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Helper Buttons
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      text: 'Example Code',
                      isOutlined: true,
                      onPressed: _insertExampleCode,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: CustomButton(
                      text: 'Clear',
                      isOutlined: true,
                      icon: Icons.delete_outline,
                      onPressed: () => _codeController.clear(),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Main Action Button
              CustomButton(
                text: _isLoading ? 'Analyzing Code...' : 'Explain Code',
                icon: Icons.auto_awesome,
                backgroundColor: AppColors.primaryPurple,
                isLoading: _isLoading,
                onPressed: _isLoading ? () {} : () async {
                  if (_codeController.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please enter or paste some code first!')),
                    );
                    return;
                  }

                  setState(() => _isLoading = true);

                  try {
                    final service = ApiService();
                    final result = await service.explainCode(
                        _codeController.text,
                        _selectedLanguage,
                        _selectedLevel
                    );
                    await HistoryService.addHistoryItem('Explain', _selectedLanguage, _codeController.text);

                    if (!mounted) return;

                    // Navigate to Result Screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ExplainResultScreen(
                          result: result,
                          originalCode: _codeController.text,
                          language: _selectedLanguage,
                        ),
                      ),
                    );
                  } catch (e) {
                    if (!mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
                    );
                  } finally {
                    if (mounted) setState(() => _isLoading = false);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}