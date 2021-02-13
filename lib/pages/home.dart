import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:proximity_pushup_counter_v2/states/database.state.dart';
import 'package:proximity_pushup_counter_v2/states/general.state.dart';
import 'package:proximity_pushup_counter_v2/widgets/goal_readout.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    GetIt.I.get<GeneralState>().setInitialState();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            HomeHeader(),
            GoalReadout(),
            FlatButton(
              onPressed: () {
                Navigator.pushNamed(context, '/session');
              },
              child: Text('Start session'),
            ),
            FlatButton(
              onPressed: () {
                Navigator.pushNamed(context, '/logs');
              },
              child: Text('Session logs'),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Text('Get your goals\ndone',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.w600)),
            ),
            IconButton(onPressed: () {}, icon: Icon(Icons.settings))
          ],
        ));
  }
}
