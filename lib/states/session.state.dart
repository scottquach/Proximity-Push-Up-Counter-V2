import 'package:rxdart/rxdart.dart';

class SessionState {
  BehaviorSubject _progress = BehaviorSubject.seeded(0);
  BehaviorSubject _inProgress = BehaviorSubject.seeded(false);

  BehaviorSubject _sessionDuration = BehaviorSubject.seeded(0);

  Stream get inProgressStream$ => _inProgress.stream;
  bool get inProgressCurrent => _inProgress.value;

  Stream get progressStream => _progress.stream;
  int get progressCurrent => _progress.value;

  Stream get sessionDurationStream => _sessionDuration.stream;
  int get sessionDurationCurrent => _sessionDuration.value;

  increment() {
    _progress.add(progressCurrent + 1);
    if (inProgressCurrent != true) {
      startSession();
    }
  }

  decrement() {
    _progress.add(progressCurrent - 1);
  }

  increaseSessionTime(seconds) {
    _sessionDuration.add(sessionDurationCurrent + seconds);
  }

  startSession() {
    _inProgress.add(true);
  }

  endSession() {
    _inProgress.add(false);
    reset();
  }


  reset() {
    _progress.add(0);
    _inProgress.add(false);
    _sessionDuration.add(0);
  }
}
