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
  final db = GetIt.instance.get<DBProvider>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8, top: 8),
              child: Row(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: Icon(Icons.chevron_left_rounded, size: 32,),
                      onPressed: () {
                        Navigator.pushNamed(context, '/home');
                      },
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        'Session Logs',
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            FutureBuilder(
              future: db.getLastDaySession(),
              builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
                if (snapshot.hasData) {
                  // print(snapshot.data);
                  return LogHighlight(
                    category: 'Last Day',
                    categoryIcon: FontAwesomeIcons.calendarDay,
                    count: snapshot.data['today'],
                    improvement:
                        snapshot.data['today'] - snapshot.data['yesterday'],
                  );
                } else
                  return Text('');
              },
            ),
            FutureBuilder(
                future: db.getLastWeekSession(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return LogHighlight(
                      category: 'Last 7 Days',
                      categoryIcon: FontAwesomeIcons.calendarWeek,
                      count: snapshot.data['week'],
                      improvement:
                          snapshot.data['week'] - snapshot.data['lastWeek'],
                    );
                  } else
                    return Text('');
                }),
            FutureBuilder(
                future: db.getLastMonthSessions(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return LogHighlight(
                      category: 'Last 30 Days',
                      categoryIcon: FontAwesomeIcons.calendarAlt,
                      count: snapshot.data['month'],
                      improvement:
                          snapshot.data['month'] - snapshot.data['lastMonth'],
                    );
                  } else
                    return Text('');
                }),
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
