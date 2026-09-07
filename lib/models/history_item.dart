// File: lib/models/history_item.dart

import 'dart:convert';

class HistoryItem {
  final String id;
  final String actionType; // 'Explain', 'Bugs', 'Improve', 'Convert'
  final String language;
  final String snippet;
  final DateTime timestamp;

  HistoryItem({
    required this.id,
    required this.actionType,
    required this.language,
    required this.snippet,
    required this.timestamp,
  });

  // Convert HistoryItem to a Map so we can save it as JSON text in SharedPreferences
  Map<String, dynamic> toJson() => {
    'id': id,
    'actionType': actionType,
    'language': language,
    'snippet': snippet,
    'timestamp': timestamp.toIso8601String(),
  };

  // Convert JSON Map back into a HistoryItem object when loading from storage
  factory HistoryItem.fromJson(Map<String, dynamic> json) => HistoryItem(
    id: json['id'],
    actionType: json['actionType'],
    language: json['language'],
    snippet: json['snippet'],
    timestamp: DateTime.parse(json['timestamp']),
  );
}