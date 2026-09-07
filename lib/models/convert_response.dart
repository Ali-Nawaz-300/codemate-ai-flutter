// File: lib/models/convert_response.dart

class ConvertResponse {
  final String convertedCode;
  final List<String> keyDifferences;

  ConvertResponse({
    required this.convertedCode,
    required this.keyDifferences,
  });

  factory ConvertResponse.fromJson(Map<String, dynamic> json) {
    return ConvertResponse(
      convertedCode: json['converted_code'] ?? '// No converted code returned.',
      keyDifferences: List<String>.from(json['key_differences'] ?? []),
    );
  }
}