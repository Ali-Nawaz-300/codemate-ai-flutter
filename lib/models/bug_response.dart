// File: lib/models/bug_response.dart

class BugResponse {
  final bool hasBugs;
  final String problem;
  final String whyItIsProblem;
  final String possibleFix;
  final String explanation;

  BugResponse({
    required this.hasBugs,
    required this.problem,
    required this.whyItIsProblem,
    required this.possibleFix,
    required this.explanation,
  });

  factory BugResponse.fromJson(Map<String, dynamic> json) {
    return BugResponse(
      hasBugs: json['has_bugs'] ?? true,
      problem: json['problem'] ?? 'No specific problem identified.',
      whyItIsProblem: json['why_it_is_problem'] ?? 'No reason provided.',
      possibleFix: json['possible_fix'] ?? 'No fix suggested.',
      explanation: json['explanation'] ?? 'No explanation provided.',
    );
  }
}