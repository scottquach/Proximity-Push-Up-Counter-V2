import 'package:rxdart/rxdart.dart';

class SessionState {
  BehaviorSubject _progress = BehaviorSubject.seeded(0);
  BehaviorSubject _started = BehaviorSubject.seeded(false);

  BehaviorSubject _sessionTimer = BehaviorSubject.seeded(0);

  Stream get startedStream$ => _started.stream;
  bool get startedCurrent => _started.value;

  Stream get progressStream => _progress.stream;
  int get progressCurrent => _progress.value;

  Stream get sessionTimerStream => _sessionTimer.stream;
  int get sessionTimerCurrent => _sessionTimer.value;

  increment() {
    _progress.add(progressCurrent + 1);
    if (startedCurrent != true) {
      startSession();
    }
  }

  decrement() {
    _progress.add(progressCurrent - 1);
  }

  startSession() {
    _started.add(true);
  }

  endSession() {
    _started.add(false);
  }

  increaseSessionTime(seconds) {
    _sessionTimer.add(sessionTimerCurrent + seconds);
  }

  reset() {
    _progress.add(0);
    _started.add(false);
    _sessionTimer.add(0);
  }
}
