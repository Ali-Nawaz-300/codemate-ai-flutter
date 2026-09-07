// File: lib/screens/convert_code_screen.dart

import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../utils/app_colors.dart';
import '../widgets/custom_button.dart';
import 'convert_result_screen.dart';
import '../services/history_service.dart';

class ConvertCodeScreen extends StatefulWidget {
  const ConvertCodeScreen({Key? key}) : super(key: key);

  @override
  State<ConvertCodeScreen> createState() => _ConvertCodeScreenState();
}

class _ConvertCodeScreenState extends State<ConvertCodeScreen> {
  final TextEditingController _codeController = TextEditingController();
  String _fromLanguage = 'Swift';
  String _toLanguage = 'Dart';
  bool _isLoading = false;

  final List<String> _languages = ['Python', 'Dart', 'Swift', 'JavaScript', 'Java', 'C++', 'PHP', 'Kotlin'];

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  void _insertExampleSwiftCode() {
    setState(() {
      _fromLanguage = 'Swift';
      _toLanguage = 'Dart';
      _codeController.text = '''let numbers = [1, 2, 3, 4, 5]
for number in numbers {
    print(number)
}''';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: const Text('Convert Code', style: TextStyle(color: AppColors.textMain, fontSize: 18)),
        iconTheme: const IconThemeData(color: AppColors.textMain),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Language Selectors Row (From -> To)
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('From', style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(color: AppColors.cardColor, borderRadius: BorderRadius.circular(8)),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: _fromLanguage,
                              isExpanded: true,
                              dropdownColor: AppColors.cardColor,
                              style: const TextStyle(color: AppColors.textMain),
                              items: _languages.map((l) => DropdownMenuItem(value: l, child: Text(l))).toList(),
                              onChanged: (val) => setState(() => _fromLanguage = val!),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 20),
                    child: Icon(Icons.swap_horiz, color: AppColors.primaryBlue),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('To', style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(color: AppColors.cardColor, borderRadius: BorderRadius.circular(8)),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: _toLanguage,
                              isExpanded: true,
                              dropdownColor: AppColors.cardColor,
                              style: const TextStyle(color: AppColors.textMain),
                              items: _languages.map((l) => DropdownMenuItem(value: l, child: Text(l))).toList(),
                              onChanged: (val) => setState(() => _toLanguage = val!),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text('Your Code', style: TextStyle(color: AppColors.textMain, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(color: AppColors.cardColor, borderRadius: BorderRadius.circular(8)),
                  child: TextField(
                    controller: _codeController,
                    maxLines: null,
                    expands: true,
                    style: const TextStyle(color: AppColors.textMain, fontFamily: 'monospace', fontSize: 14),
                    decoration: const InputDecoration(
                      hintText: 'Paste code to convert...',
                      hintStyle: TextStyle(color: AppColors.textSecondary),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(16),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(child: CustomButton(text: 'Example Code', isOutlined: true, onPressed: _insertExampleSwiftCode)),
                  const SizedBox(width: 12),
                  Expanded(child: CustomButton(text: 'Clear', isOutlined: true, icon: Icons.delete_outline, onPressed: () => _codeController.clear())),
                ],
              ),
              const SizedBox(height: 16),
              CustomButton(
                text: _isLoading ? 'Converting...' : 'Convert Code',
                icon: Icons.transform,
                backgroundColor: AppColors.primaryBlue,
                isLoading: _isLoading,
                onPressed: _isLoading ? () {} : () async {
                  if (_codeController.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please enter some code!')));
                    return;
                  }
                  setState(() => _isLoading = true);
                  try {
                    final service = ApiService();
                    final result = await service.convertCode(_codeController.text, _fromLanguage, _toLanguage);
                    await HistoryService.addHistoryItem('Convert', '$_fromLanguage to $_toLanguage', _codeController.text);                    if (!mounted) return;
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ConvertResultScreen(result: result, targetLanguage: _toLanguage)));
                  } catch (e) {
                    if (!mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red));
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