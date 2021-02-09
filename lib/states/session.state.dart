import 'package:proximity_pushup_counter_v2/models/session.model.dart';
import 'package:proximity_pushup_counter_v2/states/database.state.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uuid/uuid.dart';
import 'package:get_it/get_it.dart';

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
    // GetIt.I.get<DBProvider>().getAllSessions();
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

  Future<dynamic> endSession() async {
    var uuid = Uuid().v1();
    Duration duration = Duration(seconds: sessionDurationCurrent);
    int dailyGoal = int.parse(await GetIt.I.get<DBProvider>().getDailyGoal());
    await Session(
      id: uuid,
      duration: duration,
      count: countCurrent,
      dailyGoal: dailyGoal,
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
