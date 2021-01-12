import 'package:flutter/material.dart';

class Session {
  int sessionCount = 0;
  DateTime sessionStart = DateTime.now();
  DateTimeRange sessionTimeRange;
  bool goalMet = false;

  void setSessionStarted () {
    this.sessionStart = DateTime.now();
  }

  void setSessonEnded () {
    if (sessionStart != null) {
      DateTimeRange(start: this.sessionStart, end: DateTime.now());
    }
  }
}