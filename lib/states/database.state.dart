import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {

  initDB() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'proximity_pushup_counter.db'),
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE logs (
            log_id INTEGER PRIMARY KEY AUTOINCREMENT, 
            session_id TEXT,
            progress INTEGER,
            entry_time TEXT,
            duration INTEGER
            daily_goal INTEGER
          ) 
        ''');

        await db.execute('''
          CREATE TABLE settings (
            id INTEGER PRIMARY KEY AUTOINCREMENT, 
            setting INTEGER,
            value TEXT,
          ) 
        ''');
      },
      version: 1
    );
  }

  insertNewSession(newSession) async {

  }

}