import 'package:flutter/material.dart';
import 'package:quizzy/services/location.dart';
import 'package:quizzy/data/city_questions.dart'; // Ensure correct import for fetching questions

class LocationMode extends StatefulWidget {
  @override
  _LocationModeState createState() => _LocationModeState();
}

class _LocationModeState extends State<LocationMode> {
  String? adminArea;
  List<Question>? questions;
  int currentQuestionIndex = 0;

  @override
  void initState() {
    super.initState();
    getLocationAndQuestions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set the background color to white
      appBar: AppBar(
        title: const Text('Location Mode'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: questions == null
            ? Center(child: CircularProgressIndicator())
            : buildQuestion(questions![currentQuestionIndex]),
      ),
    );
  }

  Widget buildQuestion(Question question) {
    return Center( // Center the content
      child: Column(
        mainAxisSize: MainAxisSize.min, // Use the minimum space
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            question.question,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black), // Make the question text black
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          ...question.options.asMap().entries.map((option) => Container(
                width: double.infinity, // Make the button full width
                margin: EdgeInsets.only(bottom: 10), // Add spacing between buttons
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, // Background color of the button
                    foregroundColor: Colors.black, // Text color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20), // Border radius
                    ),
                    side: BorderSide(color: Colors.grey), // Border color
                  ),
                  onPressed: () {
                    // Handle option selection
                    setState(() {
                      if (currentQuestionIndex < questions!.length - 1) {
                        currentQuestionIndex++;
                      } else {
                        // Quiz finished, handle accordingly
                        showQuizCompletedDialog();
                      }
                    });
                  },
                  child: Text(option.value),
                ),
              )).toList(),
        ],
      ),
    );
  }

  void showQuizCompletedDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Quiz Completed"),
          content: Text("You have completed the quiz."),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  currentQuestionIndex = 0; // Reset the quiz
                });
              },
            ),
          ],
        );
      },
    );
  }

  void getLocationAndQuestions() async {
    final service = LocationService();
    final locationData = await service.getLocation();

    if (locationData != null) {
      final placeMark = await service.getPlaceMark(locationData: locationData);

      setState(() {
        adminArea = placeMark?.administrativeArea ?? 'Could not get admin area';
        questions = fetchQuestionsForCity(adminArea!);
      });
    }
  }
}
