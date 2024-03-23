import 'package:flutter/material.dart';

import 'package:quizzy/questions_screen.dart';
import 'package:quizzy/start_screen.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  bool isStartScreen = true; // Flag to track the active screen

  void switchScreen() {
    setState(() {
      isStartScreen = false; // Change flag when switching screens
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: isStartScreen
            ? AppBar(
                backgroundColor: Color.fromARGB(255, 78, 13, 151), // Transparent AppBar
                elevation: 0, // No shadow
                leading: IconButton(
                  icon: Icon(Icons.star, color: Colors.white, size: 50), // Your star icon here
                  onPressed: () {
                    // Action for star icon
                  },
                ),
                actions: [
                  IconButton(
                    icon: Icon(Icons.account_circle, color: Colors.white, size: 40), // Your account icon here
                    onPressed: () {
                      // Action for account icon
                    },
                  ),
                ],
              )
            : null, // No AppBar for the QuestionsScreen
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
          child: isStartScreen ? StartScreen(switchScreen) : const QuestionsScreen(),
        ),
      ),
    );
  }
}

