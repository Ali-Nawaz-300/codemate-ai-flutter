# CodeMate AI 🤖

CodeMate AI is a focused, AI-powered mobile coding assistant built with Flutter. It helps developers analyze, debug, optimize, and translate source code using Google's Gemini Large Language Model via a REST API integration.

## Features
* **Explain Code:** Breaks down complex logic into beginner, intermediate, or advanced explanations.
* **Find Bugs:** Analyzes syntax and logic errors, providing detailed explanations and actionable fixes.
* **Improve Code:** Refactors unoptimized code for better performance, readability, and modern best practices.
* **Convert Code:** Translates source code across 8+ programming languages while highlighting key syntax differences.
* **Local History:** Automatically saves all AI interactions locally using SharedPreferences.

## Tech Stack
* **Framework:** Flutter / Dart
* **API Integration:** `http` (REST API)
* **AI Model:** Google Gemini 3.6 Flash
* **State Management:** Stateful Widgets
* **Local Storage:** SharedPreferences
* **Data Parsing:** Native Dart JSON Serialization

## Setup Instructions
1. Clone the repository.
2. Get a free API key from Google AI Studio.
3. Rename `lib/utils/api_constants.example.dart` to `api_constants.dart` and insert your API key.
4. Run `flutter pub get` to install dependencies.
5. Run `flutter run` to launch the app.
