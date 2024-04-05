import 'package:quizzy/data/local/db.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:convert';

class Manager {

  Future<void> insertSampleData() async {
    print("Attempting to insert sample data...");
    Database db = await DatabaseHelper.instance.database;
    await db.transaction((txn) async {
      // Check if the city exists and get its ID
      var existingCities = await txn.query(DatabaseHelper.tableCities, where: 'name = ?', whereArgs: ['Aveiro']);
      int cityId;
      
      if (existingCities.isEmpty) {
        Map<String, dynamic> city = {'name': 'Aveiro'};
        cityId = await txn.insert(DatabaseHelper.tableCities, city);
        print("Inserted city with ID: $cityId");
      } else {
        cityId = existingCities.first['id'] as int? ?? 0;
      }

      Map<String, dynamic> question = {
        'question': 'Porto is famous for its production of what type of alcohol?',
        'options': jsonEncode(['Port wine', 'Vinho Verde', 'Madeira', 'Moscatel', 'Douro River']),
        'answerIndex': 0,
        'cityId': cityId,
      };


      int questionId = await txn.insert(DatabaseHelper.tableQuestions, question);
      print("Inserted question with ID: $questionId");
    }).catchError((error) {
      print('Error inserting sample data: $error');
    });
  }

    Future<void> deleteQuestionsByIds(List<int> ids) async {
    final db = await DatabaseHelper.instance.database;
    for (var id in ids) {
      await db.delete(
        DatabaseHelper.tableQuestions,
        where: 'id = ?',
        whereArgs: [id],
      );
      print('Deleted question with ID: $id');
    }
  }


    Future<void> printAllCities() async {
    final db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> cities = await db.query(DatabaseHelper.tableCities);
    print('All Cities:');
    cities.forEach((city) => print(city));
  }
    Future<void> printAllQuestions() async {
    final db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> questions = await db.query(DatabaseHelper.tableQuestions);
    print('All Questions:');
    questions.forEach((question) => print(question));
  }


}
