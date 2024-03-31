import 'package:flutter/material.dart';
import 'package:quizzy/services/location.dart';
import 'package:quizzy/data/city_questions.dart'; // Your existing imports

// Assuming you have the sensors package added for sensor-based challenges
import 'package:sensors_plus/sensors_plus.dart';

// Enum to distinguish between challenge types
enum ChallengeType { locationQuestion, sensorChallenge }

class ChallengeMode extends StatefulWidget {
  @override
  _ChallengeModeState createState() => _ChallengeModeState();
}

class _ChallengeModeState extends State<ChallengeMode> {
  String? adminArea;
  List<dynamic>? challenges; // Now can include both Questions and SensorChallenges
  int currentChallengeIndex = 0;
  ChallengeType currentChallengeType = ChallengeType.locationQuestion;

  @override
  void initState() {
    super.initState();
    getLocationAndChallenges();
  }

  @override
  Widget build(BuildContext context) {
    // Dynamically build UI based on the current challenge type
    if (challenges == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Challenge Mode')),
        body: Center(child: CircularProgressIndicator()),
      );
    } else {
      return Scaffold(
        appBar: AppBar(title: const Text('Challenge Mode')),
        body: currentChallengeType == ChallengeType.locationQuestion
            ? buildQuestion(challenges![currentChallengeIndex])
            : buildSensorChallenge(challenges![currentChallengeIndex]), // Implement this method
      );
    }
  }

  Widget buildQuestion(Question question) {
    // Building question UI, similar to your existing method
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              question.question,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ...question.options.asMap().entries.map((option) => ElevatedButton(
                  onPressed: () => selectOption(option.key, question.answerIndex),
                  child: Text(option.value),
                )).toList(),
          ],
        ),
      ),
    );
  }

  void selectOption(int selectedOptionIndex, int correctAnswerIndex) {
    // Logic to handle option selection, including advancing challenges
    if (selectedOptionIndex == correctAnswerIndex) {
      // Correct answer logic
    } else {
      // Incorrect answer logic
    }
    advanceChallenge();
  }

  Widget buildSensorChallenge(dynamic sensorChallenge) {
    // Placeholder method to build sensor challenge UI
    return Center(child: Text('Sensor Challenge Placeholder'));
  }

  void advanceChallenge() {
    // Logic to advance challenges, alternating types
    if (currentChallengeIndex < challenges!.length - 1) {
      setState(() {
        currentChallengeIndex++;
        currentChallengeType = currentChallengeType == ChallengeType.locationQuestion
            ? ChallengeType.sensorChallenge
            : ChallengeType.locationQuestion;
      });
    } else {
      // End of challenges, show completion dialog or reset
      showQuizCompletedDialog();
    }
  }

  void getLocationAndChallenges() async {
    // Your existing logic to fetch location and questions, then mixing in sensor challenges
    final service = LocationService();
    final locationData = await service.getLocation();
    if (locationData != null) {
      final placeMark = await service.getPlaceMark(locationData: locationData);
      setState(() {
        adminArea = placeMark?.administrativeArea ?? 'Unknown';
        var fetchedQuestions = fetchQuestionsForCity(adminArea!);
        challenges = intercalateQuestionsWithSensorChallenges(fetchedQuestions);
      });
    }
  }

  List<dynamic> intercalateQuestionsWithSensorChallenges(List<Question> questions) {
    // Method to intercalate questions with sensor challenges
    List<dynamic> mixedChallenges = [];
    for (var i = 0; i < questions.length; i++) {
      mixedChallenges.add(questions[i]);
      // Add a sensor challenge placeholder or actual sensor challenge object here
      if (i < questions.length - 1) { // Avoid adding a sensor challenge after the last question
        mixedChallenges.add("Sensor Challenge Placeholder");
      }
    }
    return mixedChallenges;
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
                  //currentQuestionIndex = 0; // Reset the quiz
                });
              },
            ),
          ],
        );
      },
    );
  }

  // void getLocationAndQuestions() async {
  //   final service = LocationService();
  //   final locationData = await service.getLocation();

  //   if (locationData != null) {
  //     final placeMark = await service.getPlaceMark(locationData: locationData);

  //     setState(() {
  //       adminArea = placeMark?.administrativeArea ?? 'Could not get admin area';
  //       questions = fetchQuestionsForCity(adminArea!);
  //     });
  //   }
  // }
}
