import 'package:flutter/material.dart';
import 'package:quizzy/widgets/app_bar.dart';
import 'package:quizzy/data/questions.dart';
import 'package:quizzy/widgets/answer_button.dart'; 
import 'package:google_fonts/google_fonts.dart';
import 'package:quizzy/widgets/exit_dialog.dart';
import 'package:quizzy/widgets/endQuiz_dialog.dart';

class QuestionsScreen extends StatefulWidget {
  final String apiUrl;
  final VoidCallback onExit;
  final String? qrScannedData; 

  const QuestionsScreen({Key? key, required this.apiUrl, required this.onExit, this.qrScannedData}) : super(key: key);

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  List<dynamic> _questions = [];
  int _currentQuestionIndex = 0;
  bool _isLoading = true;
  String? _selectedAnswer;
  bool _isAnswerCorrect = false;

  @override
  void initState() {
   super.initState();
  _loadQuestions();
}

  void _loadQuestions() async {
    try {
      final questions = await fetchTriviaQuestions(widget.apiUrl);
      final processedQuestions = questions.map((question) {
        final List<dynamic> allAnswers = List.from(question['incorrect_answers'])
          ..add(question['correct_answer']);
        allAnswers.shuffle(); 
        return {
          ...question,
          'shuffled_answers': allAnswers, // Store shuffled answers back in the question
        };
      }).toList();

        setState(() {
          _questions = processedQuestions;
          _isLoading = false;
        });
    } catch (e) {
      print("Failed to load questions: $e");
      
    }
  }

  void _answerQuestion(String selectedAnswer) {
  final correctAnswer = _questions[_currentQuestionIndex]['correct_answer'];
  bool isAnswerCorrect = selectedAnswer == correctAnswer;

  setState(() {
    _selectedAnswer = selectedAnswer;
    _isAnswerCorrect = isAnswerCorrect;
  });

  Future.delayed(Duration(seconds: 1), () {
  if (_currentQuestionIndex < _questions.length - 1) {
    setState(() {
      _currentQuestionIndex++;
      _selectedAnswer = null; // Reset for the next question
    });
  } else {
    EndQuizDialog.show(context, widget.onExit);
  }
});
}





  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final currentQuestion = _questions[_currentQuestionIndex];
    final List<dynamic> answers = currentQuestion['shuffled_answers'];

    return Scaffold(
      appBar: QuizzyAppBar  (height: AppBar().preferredSize.height,
      leadingIcon: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
          onPressed: () {
             ExitDialog.show(context, widget.onExit);
          },
        ),
      ),
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
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              ...answers.map((answer) {
                bool isSelected = answer == _selectedAnswer;
                Color color = Colors.blue; // Default color
                if (isSelected) {
                  color = _isAnswerCorrect ? Colors.green : Colors.red;
                }
                return AnswerButton(
                  answerText: answer,
                  onTap: () => _answerQuestion(answer),
                  color: color,
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );

    
  }


}
