import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GoalEdit extends StatefulWidget {
  @override
  _GoalEditState createState() => _GoalEditState();
}

class _GoalEditState extends State<GoalEdit> {
  int currentGoal = 25;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      // width: double.infinity,
      // height: 400,
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8), topRight: Radius.circular(8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Change daily goal',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
          ),
          Expanded(
            child: Center(
              child: Text('$currentGoal',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 96)),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlineButton(
                  padding: EdgeInsets.all(8),
                  onPressed: () {
                    setState(() {
                      if (currentGoal >= 5) {
                        currentGoal -= 5;
                      }
                    });
                  },
                  shape: CircleBorder(),
                  child: Text(
                    '-5',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                ),
                OutlineButton(
                  padding: EdgeInsets.all(8),
                  onPressed: () {
                    setState(() {
                      if (currentGoal > 0) {
                        currentGoal -= 1;
                      }
                    });
                  },
                  shape: CircleBorder(),
                  child: Text(
                    '-1',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36),
                  ),
                ),
                OutlineButton(
                  padding: EdgeInsets.all(8),
                  onPressed: () {
                    setState(() {
                      currentGoal += 1;
                    });
                  },
                  shape: CircleBorder(),
                  child: Text(
                    '+1',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36),
                  ),
                ),
                OutlineButton(
                  padding: EdgeInsets.all(8),
                  onPressed: () {
                    setState(() {
                      currentGoal += 5;
                    });
                  },
                  shape: CircleBorder(),
                  child: Text(
                    '+5',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: FaIcon(FontAwesomeIcons.save, size: 18,),
              label: Text('Save'),
            ),
          )
        ],
      ),
    );
  }
}
