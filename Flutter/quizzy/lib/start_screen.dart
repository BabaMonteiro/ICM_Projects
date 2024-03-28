import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizzy/profile.dart';
import 'package:quizzy/challenge_mode.dart';


class StartScreen extends StatelessWidget {
  final void Function(String apiUrl)
      startQuiz; // Adjusted to accept a String parameter

  const StartScreen(this.startQuiz, {super.key});

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 78, 13, 151),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.star, color: Colors.white, size: 50),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ProfileScreen(),
              ),
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle, color: Colors.white, size: 50),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfileScreen(),
                ),
              );
            },
          ),
        ],
      ),
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
      child: Center(
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
      ),
    )
    );
  }

  void _showOptionsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Choose an option'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GestureDetector(
                  child: const Text('Classic Game'),
                  onTap: () {
                    Navigator.of(context).pop(); 
                    startQuiz(
                        "https://opentdb.com/api.php?amount=30&difficulty=easy&type=multiple"); 
                  },
                ),
                Padding(padding: EdgeInsets.all(8.0)),
                GestureDetector(
                  child: Text('Categories'),
                  onTap: () {
                    Navigator.of(context).pop(); 
                    _showCategoriesDialog(
                        context);
                  },
                ),
                GestureDetector(
                  child: const Text('Challenge Mode'),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ChallengeMode(),
                    ));
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
                    startQuiz(
                        "https://opentdb.com/api.php?amount=30&category=22&difficulty=easy&type=multiple");
                  },
                ),
                GestureDetector(
                  child: Text('History'),
                  onTap: () {
                    Navigator.of(context).pop();
                    startQuiz(
                        "https://opentdb.com/api.php?amount=30&category=23&difficulty=easy&type=multiple");
                  },
                ),
                GestureDetector(
                  child: Text('Art'),
                  onTap: () {
                    Navigator.of(context).pop();
                    startQuiz(
                        "https://opentdb.com/api.php?amount=30&category=25&difficulty=easy&type=multiple");
                  },
                ),
                GestureDetector(
                  child: Text('Sports'),
                  onTap: () {
                    Navigator.of(context).pop();
                    startQuiz(
                        "https://opentdb.com/api.php?amount=30&category=21&difficulty=easy&type=multiple");
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
