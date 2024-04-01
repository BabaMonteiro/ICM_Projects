import 'package:flutter/material.dart';
import 'package:quizzy/services/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; 
import 'package:quizzy/data/city_questions.dart'; // Ensure correct import for fetching questions

class LocationMode extends StatefulWidget {
  @override
  _LocationModeState createState() => _LocationModeState();
}

class _LocationModeState extends State<LocationMode> {
  String? adminArea;
  List<Question>? questions;
  int currentQuestionIndex = 0;
  int selectedOptionIndex = -1;

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
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            question.question,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          ...question.options.asMap().entries.map((option) {
            bool isSelected = selectedOptionIndex == option.key;
            bool isCorrect = question.answerIndex == option.key;
            Color bgColor = isSelected
                ? isCorrect ? Colors.green : Colors.red
                : Colors.white; // Decide color based on selection and correctness
            return Container(
              width: double.infinity,
              margin: EdgeInsets.only(bottom: 10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: bgColor,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  side: BorderSide(color: Colors.grey),
                ),
                onPressed: () async {
                  setState(() {
                    selectedOptionIndex = option.key; 
                  });
                  await Future.delayed(Duration(seconds: 1), () {
                    if (currentQuestionIndex < questions!.length - 1) {

                      setState(() {
                        currentQuestionIndex++;
                        selectedOptionIndex = -1; 
                        
                      });
                    } else {

                      showQuizCompletedDialog();

                    }
                  });
                },
                child: Text(option.value),
              ),
            );
          }).toList(),
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
      print("I get here 2");
      final placeMark = await service.getPlaceMark(locationData: locationData);

      if (placeMark != null) {
        final adminArea = placeMark.administrativeArea; 
        if (adminArea != null) {
          print("I get here 3");
          fetchQuestionsForCity(adminArea, (questions) {
            setState(() {
              this.questions = questions;
            });
          });
        }
      }
    }
  }


  //   void fetchQuestionsForCity(String city) async {
  //   print('Fetching questions for city: $city');
  //   var url = Uri.parse('http://192.168.1.204:8000/cities/all?city=${Uri.encodeComponent(city)}'); 
  //   try {
  //     final response = await http.get(url);
  //     print('Response status: ${response.statusCode}');
  //     print('Response body: ${response.body}');
  //     if (response.statusCode == 200) {
  //       final data = json.decode(response.body) as List;
  //       final List<City> cities = data.map((cityJson) => City.fromJson(cityJson)).toList();
  //       // Assuming you're interested in the first city and its questions
  //       if (cities.isNotEmpty) {
  //         setState(() {
  //           questions = cities.first.questions;
  //         });
  //   }
  //     } else {
  //       print('Failed to fetch questions. Status code: ${response.statusCode}');
  //       throw Exception('Failed to load questions');
  //     }
  //   } catch (e) {
  //     print('Error fetching questions: $e');
  //   }
  // }

}
