# CodeMate AI 🤖

CodeMate AI is a mobile coding assistant built with **Flutter** and **Dart**. It connects to the **Google Gemini API** to help developers understand, review, improve and convert source code.

The project explores practical AI integration, REST API communication, local history and responsive Flutter interface development.

## Key Features

- **Explain Code** — Generates beginner, intermediate or advanced explanations for submitted code.
- **Find Bugs** — Identifies possible syntax or logic problems and suggests potential fixes.
- **Improve Code** — Suggests improvements for readability, structure and maintainability.
- **Convert Code** — Converts code between multiple programming languages and explains important syntax differences.
- **Local History** — Saves previous interactions locally using SharedPreferences.
- **Structured AI Responses** — Parses API responses and presents them in a readable mobile interface.

## Technologies Used

- **Flutter** — Cross-platform application framework
- **Dart** — Primary programming language
- **Google Gemini API** — AI-powered code analysis and explanations
- **HTTP Package** — REST API communication
- **SharedPreferences** — Local interaction-history storage
- **Dart JSON Utilities** — Request and response data handling
- **Stateful Widgets** — Interface and application-state management

## How It Works

1. The user enters or pastes source code.
2. The user selects an action such as Explain, Find Bugs, Improve or Convert.
3. CodeMate AI sends the request to the Gemini API.
4. The application processes the response and displays the result.
5. The interaction is stored locally for later viewing.

## Running the Project

### Requirements

Before running the application, ensure that you have:

- [Flutter SDK](https://docs.flutter.dev/get-started/install)
- Android Studio or Xcode
- A Google Gemini API key from [Google AI Studio](https://aistudio.google.com/)
- An Android emulator, iOS Simulator or supported physical device

### Installation

1. Clone the repository:

```bash
git clone https://github.com/Ali-Nawaz-300/codemate-ai-flutter.git
```

2. Open the project directory:

```bash
cd codemate-ai-flutter
```

3. Install the required Flutter packages:

```bash
flutter pub get
```

4. Rename the example configuration file:

```text
lib/utils/api_constants.example.dart
```

to:

```text
lib/utils/api_constants.dart
```

5. Add your Gemini API key inside `api_constants.dart`.

6. Run the application:

```bash
flutter run
```

## API Key Security

The real `api_constants.dart` file must remain excluded from Git using `.gitignore`.

```gitignore
lib/utils/api_constants.dart
```

Only the example configuration file should be committed. Never add a real API key to the public repository.

For a production application, sensitive API access should be handled through a secure backend service rather than storing an unrestricted key directly inside the mobile application.

## What I Practiced

Through this project, I practiced:

- Connecting a Flutter application to a REST API
- Sending structured prompts to an AI model
- Processing JSON request and response data
- Handling loading and error states
- Managing local application history
- Building reusable Flutter interfaces
- Working with asynchronous Dart code

## Important Note

AI-generated explanations and suggestions may not always be correct. Developers should review and test generated code before using it in production.

## Author

**Ali Nawaz**  
iOS and Flutter Developer based in Lahore, Pakistan

- [Portfolio](https://ali-nawaz-300.github.io)
- [LinkedIn](https://www.linkedin.com/in/ali-nawaz-ios)
- [GitHub](https://github.com/Ali-Nawaz-300)
