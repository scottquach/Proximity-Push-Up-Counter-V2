import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LogsPage extends StatefulWidget {
  @override
  _LogsPageState createState() => _LogsPageState();
}

class _LogsPageState extends State<LogsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  'Session Logs',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
              ),
            ),
            LogHighlight(
              category: 'Today',
              categoryIcon: FontAwesomeIcons.calendarDay,
              count: 12,
              improvement: 4,
            ),
            LogHighlight(
              category: 'Week',
              categoryIcon: FontAwesomeIcons.calendarWeek,
              count: 52,
              improvement: 12,
            ),
            LogHighlight(
              category: 'Month',
              categoryIcon: FontAwesomeIcons.calendarAlt,
              count: 234,
              improvement: -15,
            ),
          ],
        ),
      ),
    );
  }
}

class LogHighlight extends StatelessWidget {
  final String category;
  final IconData categoryIcon;
  final int count;
  final int improvement;

  LogHighlight(
      {this.category, this.categoryIcon, this.count, this.improvement});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12, left: 12, right: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(right: 12),
                padding: EdgeInsets.all(12),
                decoration: ShapeDecoration(
                  color: Colors.grey[300],
                  shape: CircleBorder(),
                ),
                child: FaIcon(
                  categoryIcon,
                  size: 18,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$category',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Text(
                    '$count Pushups',
                    style: TextStyle(fontSize: 18),
                  )
                ],
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 4),
                child: Text(
                  improvement > 0 ? '+$improvement' : '$improvement',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: improvement > 0 ? Colors.greenAccent[700] : Colors.redAccent[400]),
                ),
              ),
              Container(
                child: FaIcon(
                    improvement > 0
                        ? FontAwesomeIcons.arrowUp
                        : FontAwesomeIcons.arrowDown,
                    size: 12,
                    color: improvement > 0 ? Colors.greenAccent[700] : Colors.redAccent[400]),
              )
            ],
          )
        ],
      ),
    );
  }
}
