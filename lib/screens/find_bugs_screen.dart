// File: lib/screens/find_bugs_screen.dart

import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../utils/app_colors.dart';
import '../widgets/custom_button.dart';
import 'bug_result_screen.dart';
import '../models/bug_response.dart';
import '../services/history_service.dart';

class FindBugsScreen extends StatefulWidget {
  const FindBugsScreen({Key? key}) : super(key: key);

  @override
  State<FindBugsScreen> createState() => _FindBugsScreenState();
}

class _FindBugsScreenState extends State<FindBugsScreen> {
  final TextEditingController _codeController = TextEditingController();
  String _selectedLanguage = 'Python';
  bool _isLoading = false;

  final List<String> _languages = ['Python', 'Dart', 'Swift', 'JavaScript', 'Java', 'C++', 'PHP'];

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  void _insertExampleBuggyCode() {
    setState(() {
      _codeController.text = '''numbers = [1, 2, 3, 4, 5]
for i in range(len(numbers) + 1):
    print(numbers[i])'''; // Intentional index out of bounds error
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: const Text('Find Bugs', style: TextStyle(color: AppColors.textMain, fontSize: 18)),
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
                      hintText: 'Paste code with bugs here...',
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
                  Expanded(child: CustomButton(text: 'Example Code', isOutlined: true, onPressed: _insertExampleBuggyCode)),
                  const SizedBox(width: 12),
                  Expanded(child: CustomButton(text: 'Clear', isOutlined: true, icon: Icons.delete_outline, onPressed: () => _codeController.clear())),
                ],
              ),
              const SizedBox(height: 16),
              CustomButton(
                text: _isLoading ? 'Analyzing Bugs...' : 'Find Bugs',
                icon: Icons.bug_report,
                backgroundColor: AppColors.primaryRed,
                isLoading: _isLoading,
                onPressed: _isLoading ? () {} : () async {
                  if (_codeController.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please enter some code!')));
                    return;
                  }
                  setState(() => _isLoading = true);
                  try {
                    final service = ApiService();
                    final result = await service.findBugs(_codeController.text, _selectedLanguage);
                    await HistoryService.addHistoryItem('Bugs', _selectedLanguage, _codeController.text);                    if (!mounted) return;
                    Navigator.push(context, MaterialPageRoute(builder: (context) => BugResultScreen(result: result, originalCode: _codeController.text)));
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