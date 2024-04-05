import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizzy/pages/location_mode.dart';
import 'package:quizzy/pages/movement_mode.dart';
import 'package:quizzy/pages/auth.dart';
import 'package:quizzy/widgets/app_bar.dart';
import 'package:quizzy/pages/qr_question.dart';

class StartScreen extends StatelessWidget {
  final void Function(String apiUrl) startQuiz;

  const StartScreen(this.startQuiz, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: QuizzyAppBar(
        height: AppBar().preferredSize.height,
        leadingIcon: IconButton(
          icon: const Icon(Icons.star, color: Colors.white, size: 35),
          onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const QrCodeQuestion()),
          );
        },
        ),
        actionIcons: [
          IconButton(
            icon: const Icon(Icons.account_circle, color: Colors.white, size: 35),
            onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AuthScreen()),
          );
        },
          ),
          // Add more action icons if needed
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF736CC6),
              Color.fromARGB(255, 78, 13, 151),
              Color.fromARGB(255, 107, 15, 168),
              Color(0xFF736CC6),
             // Color(0xFFFF8675)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('images/LOGO.png', width: 300),
              const SizedBox(height: 80),
              Text(
                'Quiz until it\'s easy!',
                style: GoogleFonts.lato(
                  color: const Color.fromARGB(255, 237, 223, 252),
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              OutlinedButton.icon(
                onPressed: () => _showOptionsDialog(context),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  side: const BorderSide(color: Colors.white, width: 3),
                  backgroundColor: const Color(0xFFFF8675),
                ),
                icon: const Icon(Icons.arrow_right_alt),
                label: const Text('START QUIZ'),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showOptionsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 165, 131, 220),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Choose an Option',
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                _buildOptionItem(
                  context,
                  'Classic Game',
                  "https://opentdb.com/api.php?amount=10&difficulty=easy&type=multiple",
                  backgroundColor: const Color.fromARGB(255, 78, 13, 151),
                ),
                SizedBox(height: 10),
                _buildOptionItem(
                  context,
                  'Categories',
                  null,
                  onTap: () {
                    Navigator.of(context).pop();
                    _showCategoriesDialog(context);
                  },
                  backgroundColor: Colors.blueGrey,
                ),
                SizedBox(height: 10),
                _buildOptionItem(
                context,
                'Challenge Mode',
                null, // No URL needed for navigating to a widget
                onTap: () {
                    Navigator.of(context).pop();
                    _showChallengeDialog(context);
                  },
                backgroundColor: Colors.deepOrange, // Choose a color that fits your app theme
              ),
              SizedBox(height: 10),
            ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildOptionItem(
    BuildContext context,
    String title,
    String? url, {
    VoidCallback? onTap,
    Color backgroundColor = Colors.transparent,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap ??
            () {
              if (url != null) {
                Navigator.of(context).pop();
                startQuiz(url);
              }
            },
        borderRadius: BorderRadius.circular(10.0),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: backgroundColor,
          ),
          child: Row(
            children: <Widget>[
              Icon(Icons.play_circle_filled, color: Colors.white),
              SizedBox(width: 10.0),
              Text(
                title,
                style: TextStyle(fontSize: 16.0, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showCategoriesDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Select a Category',
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                _buildCategoryItem(
                  context,
                  'Geography',
                  "https://opentdb.com/api.php?amount=10&category=22&difficulty=easy&type=multiple",
                  Icons.location_on, // Geography icon
                  Color.fromARGB(255, 42, 26, 121), // Blue color for Geography
                ),
                SizedBox(height: 10),
                _buildCategoryItem(
                  context,
                  'History',
                  "https://opentdb.com/api.php?amount=10&category=23&difficulty=easy&type=multiple",
                  Icons.history, // History icon
                  Color.fromARGB(255, 210, 126, 0), // Orange color for History
                ),
                SizedBox(height: 10),
                _buildCategoryItem(
                  context,
                  'Art',
                  "https://opentdb.com/api.php?amount=10&category=25&difficulty=easy&type=multiple",
                  Icons.palette, // Art icon
                  const Color.fromARGB(255, 5, 134, 9), // Green color for Art
                ),
                SizedBox(height: 10),
                _buildCategoryItem(
                  context,
                  'Sports',
                  "https://opentdb.com/api.php?amount=10&category=21&difficulty=easy&type=multiple",
                  Icons.sports_soccer, // Sports icon
                  const Color.fromARGB(255, 187, 18, 6), // Red color for Sports
                ),
                // Add more categories as needed
                SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }


  Widget _buildCategoryItem(BuildContext context, String title, String url, IconData iconData, Color color) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.of(context).pop();
          startQuiz(url);
        },
        borderRadius: BorderRadius.circular(10.0),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: color, // Assigning specific color to each category
          ),
          child: Row(
            children: <Widget>[
              Icon(
                iconData,
                color: Colors.white,
              ),
              SizedBox(width: 10.0),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
              ),
              ),
            ],
          ),
        ),
      ),
    );
  }

    void _showChallengeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 165, 131, 220),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Select your Challenge Mode',
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                _buildOptionItem(
                context,
                'Location Mode',
                null, 
                onTap: () {
                  Navigator.of(context).pop(); 
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LocationMode()),
                  );
                },
                backgroundColor: Color.fromARGB(255, 109, 109, 109), 
              ),SizedBox(height: 10),
                _buildOptionItem(
                context,
                'Movement Mode',
                null, 
                onTap: () {
                  Navigator.of(context).pop(); 
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MovementMode()), 
                  );
                },
                backgroundColor: Color.fromARGB(255, 151, 65, 133),
              ),
              SizedBox(height: 10),
            ],
            ),
          ),
        );
      },
    );
  }
}