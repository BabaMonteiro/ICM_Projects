import 'package:http/http.dart' as http;
import 'dart:convert';



Future<List<dynamic>> fetchTriviaQuestions() async {
  final String apiUrl = "https://opentdb.com/api.php?amount=50&type=multiple";
  final response = await http.get(Uri.parse(apiUrl));

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return data['results']; 
    
  } else {

    throw Exception('Failed to load trivia questions');
  }
}
