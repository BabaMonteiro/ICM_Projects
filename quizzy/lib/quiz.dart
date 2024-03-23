import 'package:flutter/material.dart';
import 'package:quizzy/questions_screen.dart';
import 'package:quizzy/start_screen.dart';

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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: isStartScreen
            ? AppBar(
                backgroundColor: Color.fromARGB(255, 78, 13, 151),
                elevation: 0,
                leading: IconButton(
                  icon: Icon(Icons.star, color: Colors.white, size: 50),
                  onPressed: () {},
                ),
                actions: [
                  IconButton(
                    icon: Icon(Icons.account_circle, color: Colors.white, size: 40),
                    onPressed: () {},
                  ),
                ],
              )
            : null, // No AppBar for the QuestionsScreen.
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 78, 13, 151),
                Color.fromARGB(255, 107, 15, 168),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: isStartScreen ? StartScreen(switchScreen) : QuestionsScreen(apiUrl: apiUrl), // Pass apiUrl to QuestionsScreen.
        ),
      ),
    );
  }
}
