// File: lib/services/history_service.dart

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/history_item.dart';

class HistoryService {
  static const String _key = 'codemate_history';

  // Save a new history item
  static Future<void> addHistoryItem(String actionType, String language, String codeSnippet) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> existing = prefs.getStringList(_key) ?? [];

    final newItem = HistoryItem(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      actionType: actionType,
      language: language,
      snippet: codeSnippet.length > 40 ? '${codeSnippet.substring(0, 40)}...' : codeSnippet,
      timestamp: DateTime.now(),
    );

    // Insert at the beginning so the newest is at the top
    existing.insert(0, jsonEncode(newItem.toJson()));
    await prefs.setStringList(_key, existing);
  }

  // Load all history items
  static Future<List<HistoryItem>> getHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> existing = prefs.getStringList(_key) ?? [];

    return existing.map((itemStr) => HistoryItem.fromJson(jsonDecode(itemStr))).toList();
  }

  // Clear all history
  static Future<void> clearHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}