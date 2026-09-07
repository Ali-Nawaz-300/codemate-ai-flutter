// File: lib/models/explain_response.dart

class ExplainResponse {
  final String summary;
  final String explanation;
  final List<String> importantConcepts;

  ExplainResponse({
    required this.summary,
    required this.explanation,
    required this.importantConcepts
  });

  // This "factory" function takes a raw JSON map and turns it into a structured Dart object.
  factory ExplainResponse.fromJson(Map<String, dynamic> json) {
    return ExplainResponse(
      summary: json['summary'] ?? 'No summary provided.',
      explanation: json['explanation'] ?? 'No explanation provided.',
      importantConcepts: List<String>.from(json['important_concepts'] ?? []),
    );
  }
}