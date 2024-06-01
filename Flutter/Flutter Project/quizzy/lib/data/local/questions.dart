import 'dart:convert';

class Question {
  final int? id; // O ID pode ser nulo antes de inserir no banco de dados
  final String question;
  final List<String> options;
  final int answerIndex;
  final int cityId;

  Question({
    this.id,
    required this.question,
    required this.options,
    required this.answerIndex,
    required this.cityId,
  });

  // Método para converter um objeto Question em um Map.
  // Útil para inserção no banco de dados.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'question': question,
      'options': jsonEncode(options), // Serializa a lista de opções como JSON
      'answerIndex': answerIndex,
      'cityId': cityId,
    };
  }

  // Método para criar um objeto Question a partir de um Map.
  // Útil para leitura do banco de dados.
  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      id: map['id'],
      question: map['question'],
      options: List<String>.from(jsonDecode(map['options'])), // Deserializa a string JSON para uma lista de strings
      answerIndex: map['answerIndex'],
      cityId: map['cityId'],
    );
  }
}
