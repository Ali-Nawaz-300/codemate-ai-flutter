// File: lib/models/improve_response.dart

class ImproveResponse {
  final String improvedCode;
  final List<String> improvements;

  ImproveResponse({
    required this.improvedCode,
    required this.improvements,
  });

  factory ImproveResponse.fromJson(Map<String, dynamic> json) {
    return ImproveResponse(
      improvedCode: json['improved_code'] ?? '// No improved code returned.',
      improvements: List<String>.from(json['improvements'] ?? []),
    );
  }
}