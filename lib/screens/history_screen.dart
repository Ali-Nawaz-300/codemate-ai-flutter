// File: lib/screens/history_screen.dart

import 'package:flutter/material.dart';
import '../models/history_item.dart';
import '../services/history_service.dart';
import '../utils/app_colors.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<HistoryItem> _historyList = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    final items = await HistoryService.getHistory();
    setState(() {
      _historyList = items;
      _isLoading = false;
    });
  }

  Future<void> _clearAll() async {
    await HistoryService.clearHistory();
    _loadHistory();
  }

  Color _getBadgeColor(String type) {
    switch (type) {
      case 'Explain': return AppColors.primaryPurple;
      case 'Bugs': return AppColors.primaryRed;
      case 'Improve': return AppColors.primaryGreen;
      case 'Convert': return AppColors.primaryBlue;
      default: return AppColors.textSecondary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: const Text('History', style: TextStyle(color: AppColors.textMain, fontSize: 18)),
        actions: [
          if (_historyList.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_outline, color: AppColors.textSecondary),
              onPressed: _clearAll,
            ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: AppColors.primaryPurple))
          : _historyList.isEmpty
          ? const Center(
        child: Text('No history yet. Run some AI code analysis!',
          style: TextStyle(color: AppColors.textSecondary),
        ),
      )
          : ListView.builder(
        itemCount: _historyList.length,
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          final item = _historyList[index];
          final badgeColor = _getBadgeColor(item.actionType);

          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.cardColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: badgeColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(Icons.code, color: badgeColor, size: 20),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${item.actionType} (${item.language})',
                            style: const TextStyle(color: AppColors.textMain, fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          Text(
                            '${item.timestamp.hour}:${item.timestamp.minute.toString().padLeft(2, '0')}',
                            style: const TextStyle(color: AppColors.textSecondary, fontSize: 11),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        item.snippet,
                        style: const TextStyle(color: AppColors.textSecondary, fontSize: 13, fontFamily: 'monospace'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}