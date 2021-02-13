import 'package:get_it/get_it.dart';
import 'package:proximity_pushup_counter_v2/states/database.state.dart';
import 'package:rxdart/rxdart.dart';

class GeneralState {
  BehaviorSubject _dailyCount = BehaviorSubject.seeded(0);
  BehaviorSubject _dailyGoal = BehaviorSubject.seeded(0);

  Stream get dailyCountStream$ => _dailyCount.stream;
  int get dailyCountCurrent => _dailyCount.value;

  Stream get dailyGoalStream$ => _dailyGoal.stream;
  int get dailyGoalCurrent => _dailyGoal.value;

  Stream<Map> get dailyGoalAndCountStream$ =>
      CombineLatestStream([dailyCountStream$, dailyGoalStream$], (values) {
        // print(values);
        return {'dailyCount': values[0], 'dailyGoal': values[1]};
      });

  setInitialState() async {
    var summary = await GetIt.I.get<DBProvider>().getTodaySummary();

    this.updateDailyCount(summary['todayCount']);
    this.updateDailyGoal(summary['dailyGoal']);
  }

  updateDailyCount(int count) {
    this._dailyCount.add(count);
  }

  updateDailyGoal(int count) {
    this._dailyGoal.add(count);
    print('daily goal updated');
    print(dailyGoalCurrent);
  }

}
