import 'package:flutter/material.dart';
import 'package:quizzy/pages/questions_screen.dart';
import 'package:quizzy/pages/start_screen.dart';

// Define a function type that accepts a String parameter.
typedef SwitchScreenCallback = void Function(String apiUrl);

class Quiz extends StatefulWidget {
  
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  bool isStartScreen = true;
  String apiUrl = ""; // Keep track of the selected API URL.

  // This method matches the SwitchScreenCallback typedef.
  void switchScreen(String selectedApiUrl) {
    setState(() {
      isStartScreen = false;
      apiUrl = selectedApiUrl; // Set the API URL based on selection.
    });
  }

  void resetToStartScreen() {
  setState(() {
    isStartScreen = true;
    apiUrl = ""; // Reset the apiUrl or adjust as necessary
  });
}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: isStartScreen
              ? StartScreen(switchScreen)
              : QuestionsScreen(
                  apiUrl: apiUrl,
  onExit: resetToStartScreen,), // Pass apiUrl to QuestionsScreen.
        ),
      );
  }
}
