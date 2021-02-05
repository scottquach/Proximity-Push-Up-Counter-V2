import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:proximity_pushup_counter_v2/models/session.model.dart';
import 'package:proximity_pushup_counter_v2/states/database.state.dart';
import 'package:proximity_pushup_counter_v2/widgets/log_highlight.dart';
import 'package:intl/intl.dart';

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
            Expanded(child: LogTable())
          ],
        ),
      ),
    );
  }
}

class LogTable extends StatefulWidget {
  @override
  _LogTableState createState() => _LogTableState();
}

class _LogTableState extends State<LogTable> {
  final db = GetIt.instance.get<DBProvider>();
  final dateFormatter = DateFormat('MM/dd/yyyy');

  List<Session> sessions = [];

  @override
  void initState() {
    super.initState();
    db.getAllSessions().then((List<dynamic> res) {
      if (res.length > 0) {
        res.forEach((item) {
          Session session = Session(
              id: item['session_id'],
              count: item['count'],
              duration: Duration(seconds: item['duration']),
              dailyGoal: item['daily_goal'],
              entryTime: DateTime.parse(item['entry_time']));

          setState(() {
            sessions.add(session);
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      // width: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: DataTable(
            columns: const <DataColumn>[
              DataColumn(label: Text('Day')),
              DataColumn(label: Text('Count'), numeric: true),
              DataColumn(label: Text('Goal met'))
            ],
            rows: sessions.map((session) {
              return DataRow(cells: [
                DataCell(Text(dateFormatter.format(session.entryTime))),
                DataCell(Text(session.count.toString())),
                DataCell(Center(
                  child: FaIcon(
                    session.count > session.dailyGoal
                        ? FontAwesomeIcons.checkCircle
                        : FontAwesomeIcons.timesCircle,
                    color: session.count > session.dailyGoal
                        ? Colors.greenAccent[700]
                        : Colors.redAccent,
                  ),
                )),
              ]);
            }).toList()),
      ),
    );
  }
}
