import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizzy/questions_screen.dart';

class StartScreen extends StatelessWidget {
  final void Function(String apiUrl) startQuiz; // Adjusted to accept a String parameter

  const StartScreen(this.startQuiz, {super.key});


  @override
  Widget build(context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'images/LOGO.png',
            width: 300,
            //color: const Color.fromARGB(150, 255, 255, 255),
          ),
          const SizedBox(
            height: 80,
          ),
          Text(
            'Quiz until it\'s easy!',
            style: GoogleFonts.lato(
              color: const Color.fromARGB(255, 237, 223, 252),
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 30),
          OutlinedButton.icon(
            onPressed: () => _showOptionsDialog(context), // Modified line
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
            ),
            icon: const Icon(Icons.arrow_right_alt),
            label: const Text('Start Quiz'),
          )
        ],
      ),
    );
  }

  void _showOptionsDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Choose an option'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              GestureDetector(
                child: Text('Classic Game'),
                onTap: () {
                  Navigator.of(context).pop(); // Close the dialog
                  startQuiz("https://opentdb.com/api.php?amount=30&difficulty=easy&type=multiple"); // Start the quiz for Classic Game
                },
              ),
              Padding(padding: EdgeInsets.all(8.0)),
              GestureDetector(
                child: Text('Categories'),
                onTap: () {
                  Navigator.of(context).pop(); // Close the first dialog
                  _showCategoriesDialog(context); // Call another method to show the categories dialog
                },
              ),
            ],
          ),
        ),
      );
    },
  );
}
void _showCategoriesDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Select a Category'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              GestureDetector(
                child: Text('Geography'),
                onTap: () {
                  Navigator.of(context).pop(); 
                  startQuiz("https://opentdb.com/api.php?amount=30&category=22&difficulty=easy&type=multiple");
                },
              ),
              GestureDetector(
                child: Text('History'),
                onTap: () {
                  Navigator.of(context).pop(); 
                  startQuiz("https://opentdb.com/api.php?amount=30&category=23&difficulty=easy&type=multiple");
                },
              ),
              GestureDetector(
                child: Text('Art'),
                onTap: () {
                  Navigator.of(context).pop(); 
                  startQuiz("https://opentdb.com/api.php?amount=30&category=25&difficulty=easy&type=multiple");
                },
              ),
              GestureDetector(
                child: Text('Sports'),
                onTap: () {
                  Navigator.of(context).pop(); 
                  startQuiz("https://opentdb.com/api.php?amount=30&category=21&difficulty=easy&type=multiple");
                },
              ),
              // Add more categories as needed
            ],
          ),
        ),
      );
    },
  );
}
}