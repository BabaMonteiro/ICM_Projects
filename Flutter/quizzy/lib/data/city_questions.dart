import 'dart:convert'; 
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class City {
  final String id;
  final String name;
  final List<Question> questions;


  City({required this.id, required this.name, required this.questions});

  factory City.fromJson(Map<String, dynamic> json) {
    List<dynamic> questionsJson = json['questions'] as List<dynamic>;
    List<Question> questions = questionsJson.map((qJson) => Question.fromJson(qJson)).toList();
    return City(
      id: json['_id'] as String,
      name: json['city'] as String,
      questions: questions,
    );
  }
}

class Question {
  final String question;
  final List<String> options;
  final int answerIndex;

  Question({required this.question, required this.options, required this.answerIndex});

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      question: json['question'] as String,
      options: List<String>.from(json['options'] as List),
      answerIndex: json['answerIndex'] as int,
    );
  }
}

Future<void> fetchQuestionsForCity(String city, Function(List<Question>) onQuestionsFetched) async {
  print('Fetching questions for city: $city');
  var url = Uri.parse('http://192.168.1.204:8000/cities/all?city=${Uri.encodeComponent(city)}'); 
  try {
    final response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;
      final List<City> cities = data.map((cityJson) => City.fromJson(cityJson)).toList();
      // Assuming you're interested in the first city and its questions
      if (cities.isNotEmpty) {
      onQuestionsFetched(cities.first.questions);
    }
    } else {
      print('Failed to fetch questions. Status code: ${response.statusCode}');
      throw Exception('Failed to load questions');
    }
  } catch (e) {
    print('Error fetching questions: $e');
  }
  // Catch block
}

