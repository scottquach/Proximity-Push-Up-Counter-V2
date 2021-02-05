import 'dart:async';
import 'package:path/path.dart';
import 'package:proximity_pushup_counter_v2/models/session.model.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  static Database _database;
  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await initDB();
    return _database;
  }

  initDB() async {
    return await openDatabase(
        join(await getDatabasesPath(), 'proximity_pushup_counter.db'),
        onCreate: (db, version) async {
      await db.execute('''
          CREATE TABLE logs (
            log_id INTEGER PRIMARY KEY AUTOINCREMENT, 
            session_id TEXT,
            count INTEGER,
            entry_time TEXT,
            duration INTEGER,
            daily_goal INTEGER
          ) 
        ''');

      await db.execute('''
          CREATE TABLE settings (
            id INTEGER PRIMARY KEY AUTOINCREMENT, 
            setting INTEGER,
            value TEXT
          ) 
        ''');
    }, version: 1);
  }

  insertNewSession(Session newSession) async {
    final db = await database;
    print(newSession);
    var insertResult = await db.insert(
      'logs',
      newSession.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace
    );

    print(insertResult);
    return insertResult;
  }

  Future<List<dynamic>> getAllSessions() async {
    final db = await database;
    var res = await db.query('logs');
    // print(res);
    return res;
  }
}
