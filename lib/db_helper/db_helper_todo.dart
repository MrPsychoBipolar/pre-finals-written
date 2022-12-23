import 'package:pre_finals_written/model/todo_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ToDoDataBaseHelper {
  static const int _dbVersion = 1;
  static const String _dbName = "ToDoDb.db";

  static Future<Database> _getDb() async {
    return openDatabase(join(await getDatabasesPath(), _dbName),
        onCreate: (db, version) async => await db.execute(
            "CREATE TABLE TodoTable(id INTEGER PRIMARY KEY, title TEXT NOT NULL, description TEXT NOT NULL);"),
        version: _dbVersion);
  }

  static Future<int> addTodo(ToDo todo) async {
    final db = await _getDb();
    return await db.insert("TodoTable", todo.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> updateToDo(ToDo todo) async {
    final db = await _getDb();
    return await db.update("TodoTable", todo.toJson(),
        where: 'id = ?',
        whereArgs: [todo.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> deleteTodo(ToDo todo) async {
    final db = await _getDb();
    return await db.delete("TodoTable", where: 'id = ?', whereArgs: [todo.id]);
  }

  static Future<List<ToDo>?> getAllToDo() async {
    final db = await _getDb();

    final List<Map<String, dynamic>> map = await db.query("TodoTable");

    if (map.isEmpty) {
      return null;
    }

    return List.generate(map.length, (index) => ToDo.fromJson(map[index]));
  }
}
