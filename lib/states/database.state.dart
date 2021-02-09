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
            setting TEXT PRIMARY KEY,
            value TEXT
          ) 
        ''');
    }, version: 1);
  }

  getDailyGoal() async {
    final db = await database;
    List<Map> maps = await db.query('settings', where: 'setting = ?', whereArgs: ['daily_goal']);
    print(maps);
    if (maps.length != 1) {
      return 10;
    }
    return maps[0]['value'];
  }

  saveDailyGoal(int goal) async {
    final db = await database;
    var result = await db.insert('settings', {
      'setting': 'daily_goal',
      'value': goal
    },conflictAlgorithm: ConflictAlgorithm.replace);
    print(result);
    return result;
  }

  insertNewSession(Session newSession) async {
    final db = await database;
    print(newSession);
    var insertResult = await db.insert('logs', newSession.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);

    print(insertResult);
    return insertResult;
  }

  Future<List<dynamic>> getAllSessions() async {
    final db = await database;
    var res = await db.query('logs');
    // print(res);
    return res;
  }

  Future<Map> getLastDaySession() async {
    final db = await database;

    var todaySummary = await db.rawQuery('''
      select coalesce(sum(count), 0) as "count" from logs where date(entry_time) > date('now', '-1 days')
    ''');

    var yesterdaySummary = await db.rawQuery('''
      select coalesce(sum(count), 0) as "count" from logs where date(entry_time) < date('now', '-1 days') and date(entry_time) > date('now', '-2 days')
    ''');

    var response = {
      'today': todaySummary[0]['count'],
      'yesterday': yesterdaySummary[0]['count']
    };
    print(response);
    return response;
  }

  Future<Map> getLastWeekSession() async {
    final db = await database;

    var weekSummary = await db.rawQuery('''
      select coalesce(sum(count), 0) as "count" from logs where date(entry_time) > date('now', '-7 days')
    ''');

    var lastWeekSummary = await db.rawQuery('''
      select coalesce(sum(count), 0) as "count" from logs where date(entry_time) < date('now', '-7 days') and date(entry_time) > date('now', '-14 days')
    ''');

    var response = {
      'week': weekSummary[0]['count'],
      'lastWeek': lastWeekSummary[0]['count']
    };
    print(response);
    return response;
  }

  Future<Map> getLastMonthSessions() async {
    final db = await database;

    var monthSummary = await db.rawQuery('''
      select coalesce(sum(count), 0) as "count" from logs where date(entry_time) > date('now', '-30 days')
    ''');

    var lastMonthSummary = await db.rawQuery('''
      select coalesce(sum(count), 0) as "count" from logs where date(entry_time) < date('now', '-30 days') and date(entry_time) > date('now', '-60 days')
    ''');

    var response = {
      'month': monthSummary[0]['count'],
      'lastMonth': lastMonthSummary[0]['count']
    };
    print(response);
    return response;
  }
}
