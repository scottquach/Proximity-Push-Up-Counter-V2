import 'package:flutter/material.dart';
import 'package:proximity_pushup_counter_v2/models/session.model.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uuid/uuid.dart';

class SessionState {
  BehaviorSubject _count = BehaviorSubject.seeded(0);
  BehaviorSubject _inProgress = BehaviorSubject.seeded(false);

  BehaviorSubject _sessionDuration = BehaviorSubject.seeded(0);

  Stream get inProgressStream$ => _inProgress.stream;
  bool get inProgressCurrent => _inProgress.value;

  Stream get countStream => _count.stream;
  int get countCurrent => _count.value;

  Stream get sessionDurationStream => _sessionDuration.stream;
  int get sessionDurationCurrent => _sessionDuration.value;

  increment() {
    _count.add(countCurrent + 1);
    if (inProgressCurrent != true) {
      startSession();
    }
  }

  decrement() {
    _count.add(countCurrent - 1);
  }

  increaseSessionTime(seconds) {
    _sessionDuration.add(sessionDurationCurrent + seconds);
  }

  startSession() {
    _inProgress.add(true);
  }

  endSession() {
    var uuid = Uuid().v1();
    Duration duration = Duration(seconds: sessionDurationCurrent);
    Session(
      id: uuid,
      duration: duration,
      count: countCurrent,
      dailyGoal: 0,
      entryTime: DateTime.now().subtract(duration)
    ).saveSession();

    reset();
  }


  reset() {
    _count.add(0);
    _inProgress.add(false);
    _sessionDuration.add(0);
  }
}
