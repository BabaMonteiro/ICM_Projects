import 'package:flutter/material.dart';
import 'package:quizzy/services/location.dart';
import 'package:quizzy/data/city_questions.dart'; // Ensure this import is correct for fetching questions

class ChallengeMode extends StatefulWidget {
  @override
  _ChallengeModeState createState() => _ChallengeModeState();
}

class _ChallengeModeState extends State<ChallengeMode> {
  String? adminArea;
  List<Question>? questions; // Store questions for the current admin area

  @override
  void initState() {
    super.initState();
    getLocationAndQuestions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Challenge Mode'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: questions == null
            ? CircularProgressIndicator() // Show loading indicator while questions are being fetched
            : ListView.builder(
                itemCount: questions!.length,
                itemBuilder: (context, index) {
                  final question = questions![index];
                  return ListTile(
                    title: Text(question.question),
                    subtitle: Text('Options: ${question.options.join(', ')}'),
                  );
                },
              ),
      ),
    );
  }

  TextStyle getStyle({double size = 20}) => TextStyle(fontSize: size, fontWeight: FontWeight.bold);

  void getLocationAndQuestions() async {
    final service = LocationService();
    final locationData = await service.getLocation();

    if (locationData != null) {
      final placeMark = await service.getPlaceMark(locationData: locationData);

      setState(() {
        adminArea = placeMark?.administrativeArea ?? 'Could not get admin area';
        questions = fetchQuestionsForCity(adminArea!); // Fetch questions for the admin area
      });
    }
  }
}
