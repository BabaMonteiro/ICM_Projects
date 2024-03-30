class Question {
  final int id;
  final String question;
  final List<String> options;
  final int answerIndex;

  Question({
    required this.id,
    required this.question,
    required this.answerIndex,
    required this.options,
  }); 
}

Map<String, List<Question>> cityQuestions = {
  'Porto': [
    Question(
      id: 1,
      question: "Question for Porto 1",
      answerIndex: 1,
      options: ['Option 1', 'Option 2', 'Option 3', 'Option 4'],
    ),
    Question(
      id: 2,
      question: "Question for Porto 2",
      answerIndex: 2,
      options: ['Option 1', 'Option 2', 'Option 3', 'Option 4'],
    ),
    Question(
      id: 3,
      question: "Question for Porto 3",
      answerIndex: 3,
      options: ['Option 1', 'Option 2', 'Option 3', 'Option 4'],
    ),
  ],
  'Aveiro': [
    Question(
      id: 21, 
      question: "Question for Aveiro 1",
      answerIndex: 0,
      options: ['Option 1', 'Option 2', 'Option 3', 'Option 4'],
    ),
    Question(
      id: 22,
      question: "Question for Aveiro 2",
      answerIndex: 1,
      options: ['Option 1', 'Option 2', 'Option 3', 'Option 4'],
    ),
    Question(
      id: 23,
      question: "Question for Aveiro 3",
      answerIndex: 2,
      options: ['Option 1', 'Option 2', 'Option 3', 'Option 4'],
    ),
  ],
};

List<Question> fetchQuestionsForCity(String city) {
  return cityQuestions[city] ?? [];
}
