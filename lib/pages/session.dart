import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:proximity_pushup_counter_v2/states/session.state.dart';

class SessionPage extends StatefulWidget {
  @override
  _SessionPageState createState() => _SessionPageState();
}

class _SessionPageState extends State<SessionPage> {
  final state = GetIt.instance.get<SessionState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                SessionTimer(),
                Container(
                  height: 550,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Opacity(
                          opacity: .75,
                          child: Text(
                            'Place phone face up under face to use proximity sensor or tap screen to increment',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.75)),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              state.increment();
                            },
                            child: Center(
                              child: StreamBuilder(
                                  stream: state.countStream,
                                  builder: (BuildContext context,
                                      AsyncSnapshot snap) {
                                    return Text(
                                      '${snap.data}',
                                      style: TextStyle(fontSize: 164),
                                    );
                                  }),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.arrow_drop_down),
                          iconSize: 64,
                          onPressed: () {
                            setState(() {
                              if (state.countCurrent > 0) {
                                state.decrement();
                              }
                            });
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            ActionItems(
              reset: () {
                state.reset();
              },
              decrement: () {
                if (state.countCurrent > 0) {
                  state.decrement();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ActionItems extends StatelessWidget {
  final Function decrement;
  final Function reset;

  ActionItems({this.reset, this.decrement});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 16),
                      child: Tooltip(
                        message: 'Reset the session',
                        child: Ink(
                          decoration: BoxDecoration(
                              color: Colors.grey[100],
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.grey[500])),
                          child: IconButton(
                            icon: Icon(Icons.replay),
                            onPressed: reset,
                            padding: EdgeInsets.all(16),
                          ),
                        ),
                      ),
                    ),
                    Tooltip(
                      message: 'Decrement progress',
                      child: Ink(
                        decoration: BoxDecoration(
                            color: Colors.grey[100],
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey[500])),
                        child: IconButton(
                          icon: Icon(Icons.exposure_minus_1),
                          onPressed: decrement,
                          padding: EdgeInsets.all(16),
                        ),
                      ),
                    ),
                  ],
                ),
                RaisedButton(
                  onPressed: () {
                    GetIt.I.get<SessionState>().endSession().then((_) {
                      Navigator.pushNamed(context, '/home');
                    });
                  },
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  elevation: 2,
                  color: Colors.grey[100],
                  child: Text(
                    'End Session',
                    style: TextStyle(fontSize: 18),
                  ),
                  padding: EdgeInsets.all(18),
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(32)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SessionTimer extends StatefulWidget {
  @override
  _SessionTimerState createState() => _SessionTimerState();
}

class _SessionTimerState extends State<SessionTimer> {
  Stream periodic;
  final state = GetIt.instance.get<SessionState>();

  pad(int num, int size) {
    var s = "000000000" + num.toString();
    return s.substring(s.length - size);
  }

  startPeriodic() {
    periodic = Stream.periodic(Duration(seconds: 1), (computation) {
      return computation;
    });
    periodic.listen((computation) {
      // print(computation);
      if (state.inProgressCurrent) {
        state.increaseSessionTime(1);
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    this.startPeriodic();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: Container(
        height: 635,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
        ),
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Session time',
                style: TextStyle(fontSize: 18),
              ),
              StreamBuilder<Object>(
                  stream: state.sessionDurationStream,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData || snapshot.data == 0) {
                      return Text('00:00',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 36));
                    }
                    int minutes = ((snapshot.data as int) / 60).floor();
                    int seconds = (snapshot.data as int) % 60;

                    String minutesFormatted = pad(minutes, 2);
                    String secondsFormatted = pad(seconds, 2);

                    return Text('$minutesFormatted:$secondsFormatted',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 36));
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
