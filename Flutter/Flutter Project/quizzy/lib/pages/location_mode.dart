import 'package:flutter/material.dart';
import 'package:quizzy/services/location.dart';
import 'package:quizzy/data/local/questions.dart';
import 'package:quizzy/widgets/app_bar.dart';
import 'package:quizzy/widgets/exit_dialog.dart'; // Ensure correct import for fetching questions
import 'package:quizzy/widgets/endQuiz_dialog.dart';
import 'package:quizzy/data/local/db.dart';
import 'package:quizzy/data/local/db_manager.dart';


class LocationMode extends StatefulWidget {
  @override
  _LocationModeState createState() => _LocationModeState();
}

class _LocationModeState extends State<LocationMode> {
  String? adminArea;
  List<Question>? questions;
  int currentQuestionIndex = 0;
  int selectedOptionIndex = -1;
  final Manager _manager = Manager();
  // int _correctAnswersCount = 0;
  // int _incorrectAnswersCount = 0;


  @override
  void initState() {
  super.initState();
  prepareData();
}

void prepareData() async {
  //await _manager.deleteQuestionsByIds([8]);
  print("i get here1!");
  await _manager.insertSampleData(); // Ensure sample data is inserted
  print("i get here2!");
  getLocationAndQuestions(); // Proceed to get location and questions
  print("i get here3!");
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set the background color to white
      appBar: QuizzyAppBar(
        height: AppBar().preferredSize.height,
        leadingIcon: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white, size: 30),
          onPressed: () {
            ExitDialog.show(context, () {
              Navigator.of(context).pop();
            });
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: questions == null || questions!.isEmpty
            ? Center(child: CircularProgressIndicator())
            // Ensure questions is checked for being non-empty before calling buildQuestion
            : buildQuestion(questions![currentQuestionIndex]),
      ),
    );
  }

  Widget buildQuestion(Question question) {
    if (questions == null) {
      return Center(child: CircularProgressIndicator());
    } else {
      
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
                //bool isCorrect = question.answerIndex == option.key;
                setState(() {
                  selectedOptionIndex = option.key;
                  // if (isCorrect) {
                  //   _correctAnswersCount++;
                  // } else {
                  //   _incorrectAnswersCount++;
                  // }
                });
                await Future.delayed(Duration(seconds: 1), () {
                  if (currentQuestionIndex < (questions?.length ?? 0) - 1) {
                    setState(() {
                      currentQuestionIndex++;
                      selectedOptionIndex = -1;
                    });
                  } else {
                    EndQuizDialog.show(context, () {
                      Navigator.of(context).pop();
                    });
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
  }

  
  void getLocationAndQuestions() async {
    print('getLocationAndQuestions started');
    try {
      final service = LocationService();
      final locationData = await service.getLocation();
      print('Location fetched: $locationData');

      if (locationData != null) {
        final placeMark = await service.getPlaceMark(locationData: locationData);
        print('PlaceMark fetched: $placeMark');

        _manager.printAllCities();
        _manager.printAllQuestions();
        if (placeMark != null && placeMark.administrativeArea != null) {
          final adminArea = placeMark.administrativeArea!;
          print('Admin Area: $adminArea');
        
          //inal String adminArea = 'Aveiro'; // Hardcoded for testing
          final questions = await DatabaseHelper.instance.fetchQuestionsForCity(adminArea);
          print('Fetched ${questions.length} questions for the city $adminArea.');

          setState(() {
            this.questions = questions;
          });
        } else {
          print('Admin area is null.');
        }
      } else {
        print('LocationData is null.');
      }
    } catch (e) {
      print('Error in getLocationAndQuestions: $e');
    }
  }

}


