// File: lib/services/api_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/explain_response.dart';
import '../utils/api_constants.dart';
import '../models/bug_response.dart';
import '../models/improve_response.dart';
import '../models/convert_response.dart';

class ApiService {
  Future<ExplainResponse> explainCode(String code, String language, String level) async {
    final url = Uri.parse('${ApiConstants.geminiBaseUrl}?key=${ApiConstants.geminiApiKey}');

    // We explicitly tell the AI exactly how to format the output (Prompt Engineering)
    final prompt = '''
    You are an expert AI coding assistant. Explain the following $language code for a $level programmer. 
    Respond strictly in JSON format with exactly these three keys:
    1. "summary": A brief 1-2 sentence overview.
    2. "explanation": A step-by-step, simple explanation of how the code works.
    3. "important_concepts": An array of strings highlighting key programming concepts used.

    Code to explain:
    $code
    ''';

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "contents": [{
            "parts": [{"text": prompt}]
          }],
          "generationConfig": {
            "response_mime_type": "application/json", // Forces Gemini to return JSON
          }
        }),
      );

      if (response.statusCode == 200) {
        // Step 1: Decode the HTTP response body
        final decodedData = jsonDecode(response.body);

        // Step 2: Dig into the Gemini structure to get the text response
        final String rawJsonText = decodedData['candidates'][0]['content']['parts'][0]['text'];

        // Step 3: Decode the text response into a Map and pass it to our Model
        final Map<String, dynamic> jsonMap = jsonDecode(rawJsonText);
        return ExplainResponse.fromJson(jsonMap);
      } else {
        throw Exception('API Failed with status: ${response.statusCode}\nBody: ${response.body}');
      }
    } catch (e) {
      throw Exception('Network error or JSON parsing failed: $e');
    }
  }
  Future<BugResponse> findBugs(String code, String language) async {
    final url = Uri.parse('${ApiConstants.geminiBaseUrl}?key=${ApiConstants.geminiApiKey}');

    final prompt = '''
    You are an expert AI code debugger. Analyze the following $language code for syntax, runtime, or logical bugs. 
    Respond strictly in JSON format with exactly these five keys:
    1. "has_bugs": boolean (true if bugs exist, false if code is clean).
    2. "problem": A short description of the bug or issue found.
    3. "why_it_is_problem": Why this causes an error or bad behavior.
    4. "possible_fix": The corrected code snippet fixing the issue.
    5. "explanation": A concise explanation of how the fix resolves it.

    Code to analyze:
    $code
    ''';

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "contents": [{
            "parts": [{"text": prompt}]
          }],
          "generationConfig": {
            "response_mime_type": "application/json",
          }
        }),
      );

      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);
        final String rawJsonText = decodedData['candidates'][0]['content']['parts'][0]['text'];
        final Map<String, dynamic> jsonMap = jsonDecode(rawJsonText);
        return BugResponse.fromJson(jsonMap);
      } else {
        throw Exception('API Failed with status: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Bug analysis failed: $e');
    }
  }
  Future<ImproveResponse> improveCode(String code, String language) async {
    final url = Uri.parse('${ApiConstants.geminiBaseUrl}?key=${ApiConstants.geminiApiKey}');

    final prompt = '''
    You are an expert refactoring assistant. Optimize and clean up the following $language code for better performance, readability, and maintainability.
    Respond strictly in JSON format with exactly these two keys:
    1. "improved_code": The full refactored code string.
    2. "improvements": An array of strings describing key changes made (e.g., performance boosts, cleaner syntax).

    Code to improve:
    $code
    ''';

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "contents": [{"parts": [{"text": prompt}]}],
          "generationConfig": {"response_mime_type": "application/json"}
        }),
      );

      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);
        final String rawJsonText = decodedData['candidates'][0]['content']['parts'][0]['text'];
        final Map<String, dynamic> jsonMap = jsonDecode(rawJsonText);
        return ImproveResponse.fromJson(jsonMap);
      } else {
        throw Exception('API Failed with status: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Improve code failed: $e');
    }
  }
  Future<ConvertResponse> convertCode(String code, String fromLang, String toLang) async {
    final url = Uri.parse('${ApiConstants.geminiBaseUrl}?key=${ApiConstants.geminiApiKey}');

    final prompt = '''
    You are an expert polyglot programmer. Translate the following $fromLang code into $toLang.
    Respond strictly in JSON format with exactly these two keys:
    1. "converted_code": The fully translated code string in $toLang.
    2. "key_differences": An array of strings explaining syntax or logic changes made during translation.

    Code to convert:
    $code
    ''';

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "contents": [{"parts": [{"text": prompt}]}],
          "generationConfig": {"response_mime_type": "application/json"}
        }),
      );

      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);
        final String rawJsonText = decodedData['candidates'][0]['content']['parts'][0]['text'];
        final Map<String, dynamic> jsonMap = jsonDecode(rawJsonText);
        return ConvertResponse.fromJson(jsonMap);
      } else {
        throw Exception('API Failed with status: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Convert code failed: $e');
    }
  }
}