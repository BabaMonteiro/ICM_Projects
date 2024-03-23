import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart';


String decodeHtmlEntities(String htmlString) {
  var document = parse(htmlString);
  return document.body!.text;
}

Future<List<dynamic>> fetchTriviaQuestions() async {
  final String apiUrl = "https://opentdb.com/api.php?amount=30&difficulty=easy&type=multiple";
  final response = await http.get(Uri.parse(apiUrl));

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    List<dynamic> questions = data['results'];

    // Decode common HTML entities
    questions = questions.map((q) {
      q['question'] = q['question'].replaceAll('&quot;', '"').replaceAll("&#039;", "'");
      return q;
    }).toList();

    return questions;
  } else {
    throw Exception('Failed to load trivia questions');
  }
}
