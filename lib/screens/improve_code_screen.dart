// File: lib/screens/improve_code_screen.dart

import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../utils/app_colors.dart';
import '../widgets/custom_button.dart';
import 'improve_result_screen.dart';
import '../services/history_service.dart';

class ImproveCodeScreen extends StatefulWidget {
  const ImproveCodeScreen({Key? key}) : super(key: key);

  @override
  State<ImproveCodeScreen> createState() => _ImproveCodeScreenState();
}

class _ImproveCodeScreenState extends State<ImproveCodeScreen> {
  final TextEditingController _codeController = TextEditingController();
  String _selectedLanguage = 'Python';
  bool _isLoading = false;

  final List<String> _languages = ['Python', 'Dart', 'Swift', 'JavaScript', 'Java', 'C++', 'PHP'];

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  void _insertExampleUnoptimizedCode() {
    setState(() {
      _codeController.text = '''numbers = [1, 2, 3, 4, 5]
sum = 0
for i in range(len(numbers)):
    sum = sum + numbers[i]
print(sum)''';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: const Text('Improve Code', style: TextStyle(color: AppColors.textMain, fontSize: 18)),
        iconTheme: const IconThemeData(color: AppColors.textMain),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Programming Language', style: TextStyle(color: AppColors.textMain, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(color: AppColors.cardColor, borderRadius: BorderRadius.circular(8)),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedLanguage,
                    isExpanded: true,
                    dropdownColor: AppColors.cardColor,
                    style: const TextStyle(color: AppColors.textMain),
                    items: _languages.map((lang) => DropdownMenuItem(value: lang, child: Text(lang))).toList(),
                    onChanged: (val) => setState(() => _selectedLanguage = val!),
                  ),
                ),
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
                      hintText: 'Paste code to optimize here...',
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
                  Expanded(child: CustomButton(text: 'Example Code', isOutlined: true, onPressed: _insertExampleUnoptimizedCode)),
                  const SizedBox(width: 12),
                  Expanded(child: CustomButton(text: 'Clear', isOutlined: true, icon: Icons.delete_outline, onPressed: () => _codeController.clear())),
                ],
              ),
              const SizedBox(height: 16),
              CustomButton(
                text: _isLoading ? 'Optimizing...' : 'Improve Code',
                icon: Icons.auto_fix_high,
                backgroundColor: AppColors.primaryGreen,
                isLoading: _isLoading,
                onPressed: _isLoading ? () {} : () async {
                  if (_codeController.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please enter some code!')));
                    return;
                  }
                  setState(() => _isLoading = true);
                  try {
                    final service = ApiService();
                    final result = await service.improveCode(_codeController.text, _selectedLanguage);
                    await HistoryService.addHistoryItem('Improve', _selectedLanguage, _codeController.text);                    if (!mounted) return;
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ImproveResultScreen(result: result, originalCode: _codeController.text)));
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