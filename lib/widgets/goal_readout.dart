import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:proximity_pushup_counter_v2/states/database.state.dart';
import 'package:proximity_pushup_counter_v2/widgets/goal_edit.dart';

class GoalReadout extends StatelessWidget {
  final int todaysCount = 5;
  final int dailyGoal = 25;
  final db = GetIt.I.get<DBProvider>();

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
          FutureBuilder<Object>(
              future: db.getDailyGoal(),
              builder: (context, snap) {
                return RichText(
                  text: TextSpan(
                      style: TextStyle(color: Colors.black, fontSize: 32),
                      children: [
                        TextSpan(
                            text: '5',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 64,
                            )),
                        TextSpan(text: ' out of '),
                        TextSpan(
                            text: '${snap.data}',
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
