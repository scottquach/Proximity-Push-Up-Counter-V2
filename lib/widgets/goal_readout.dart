import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:proximity_pushup_counter_v2/states/database.state.dart';
import 'package:proximity_pushup_counter_v2/states/general.state.dart';
import 'package:proximity_pushup_counter_v2/widgets/goal_edit.dart';

class GoalReadout extends StatelessWidget {
  final int todaysCount = 5;
  final int dailyGoal = 25;
  final db = GetIt.I.get<DBProvider>();
  final generalState = GetIt.I.get<GeneralState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.fromLTRB(12, 0, 12, 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: Colors.grey[200]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Daily Goal',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
              ),
              IconButton(
                icon: FaIcon(
                  FontAwesomeIcons.edit,
                  size: 18,
                ),
                onPressed: () {
                  showModalBottomSheet(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      builder: (context) {
                        return GoalEdit();
                      },
                      context: context);
                },
              )
            ],
          ),
          StreamBuilder<Object>(
              stream: generalState.dailyGoalAndCountStream$,
              builder: (context, snap) {
                print(snap);
                if (!snap.hasData) {
                  return Text("");
                }
                int dailyCount = (snap.data as Map)["dailyCount"];
                int dailyGoal = (snap.data as Map)["dailyGoal"];

                return RichText(
                  text: TextSpan(
                      style: TextStyle(color: Colors.black, fontSize: 32),
                      children: [
                        TextSpan(
                            text: '${dailyCount.toString()}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 64,
                            )),
                        TextSpan(text: ' out of '),
                        TextSpan(
                            text: '${dailyGoal.toString()}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 64,
                            ))
                      ]),
                );
              })
        ],
      ),
    );
  }
}
