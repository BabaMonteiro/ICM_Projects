import 'package:flutter/material.dart';
import 'package:quizzy/data/questions.dart'; // Ensure this path matches where you placed fetchTriviaQuestions
import 'package:quizzy/answer_button.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({Key? key}) : super(key: key);

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  List<dynamic> _questions = []; // lista das questões
  int _currentQuestionIndex = 0; // index da questão atual
  bool _isLoading = true; // loading while fetching

  @override
  void initState() {
    super.initState();
    _loadQuestions(); // carrega as questões (vai buscar ao ficheiro data/questions.dart)
  }

  void _loadQuestions() async {
    try {
      // fetch trivia questions from the API
      final questions = await fetchTriviaQuestions();
      setState(() {
        _questions = questions;
        _isLoading = false; 
      });
    } catch (e) {
      print("Failed to load questions: $e");
    }
  }

  void _answerQuestion(bool option) {
    // handle right or wrong answer
    if (option){
      print('Correct!');
      
    } else {
      print('Wrong!');
    }
    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
      });
    } else {
    //TODO
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final currentQuestion = _questions[_currentQuestionIndex];
    final List<dynamic> answers = List.from(currentQuestion['incorrect_answers'])
      ..add(currentQuestion['correct_answer'])
      ..shuffle();

    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Container(
          margin: const EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                currentQuestion['question'],
                style: GoogleFonts.lato(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              ...answers.map((answer) {
                return AnswerButton(answerText: answer, onTap: () => _answerQuestion(answer == currentQuestion['correct_answer']),);
              }),
            ],
          ),
        ),
      ),
    );
  }
}
