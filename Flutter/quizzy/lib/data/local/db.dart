import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:quizzy/data/local/questions.dart';

class DatabaseHelper {
  static final _databaseName = "QuizzyDatabase.db";
  static final _databaseVersion = 1;

  static final tableCities = 'cities';
  static final tableQuestions = 'questions';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();


  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $tableCities (
            id INTEGER PRIMARY KEY,
            name TEXT NOT NULL
          )
          ''');

    await db.execute('''
          CREATE TABLE $tableQuestions (
            id INTEGER PRIMARY KEY,
            question TEXT NOT NULL,
            options TEXT NOT NULL,
            answerIndex INTEGER NOT NULL,
            cityId INTEGER NOT NULL,
            FOREIGN KEY (cityId) REFERENCES $tableCities (id)
          )
          ''');
  }

  // // Exemplo de inserção de dados
  // Future<int> insertCity(Map<String, dynamic> row) async {
  //   Database db = await instance.database;
  //   return await db.insert(tableCities, row);
  // }

  //   Future<int> insertQuestion(Map<String, dynamic> row) async {
  //   Database db = await instance.database;
  //   return await db.insert(tableQuestions, row);
  // }



  Future<List<Question>> fetchQuestionsForCity(String cityName) async {
    final db = await database;
    final List<Map<String, dynamic>> cityMaps = await db.query('cities', where: 'name = ?', whereArgs: [cityName]);
    
    if (cityMaps.isNotEmpty) {
      final cityId = cityMaps.first['id'] as int;
      final List<Map<String, dynamic>> questionMaps = await db.query('questions', where: 'cityId = ?', whereArgs: [cityId]);
      
      // Mapeia cada 'map' para um objeto Question usando Question.fromMap e retorna a lista
      return questionMaps.map((map) => Question.fromMap(map)).toList();
    } else {
      return []; // Retorna uma lista vazia se não houver nenhuma cidade correspondente
    }
  }
}
