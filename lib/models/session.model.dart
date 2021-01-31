import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:proximity_pushup_counter_v2/states/database.state.dart';

class Session {
  final String id;
  final Duration duration;
  final int count;
  final int dailyGoal;
  final DateTime entryTime;

  Session({
    this.id,
    this.duration,
    this.count,
    this.dailyGoal,
    this.entryTime,
  });

  saveSession() {
    GetIt.I.get<DBProvider>().insertNewSession(this);
  }
}
