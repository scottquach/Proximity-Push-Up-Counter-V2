import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/logs');
              },
              child: Container(
                margin: EdgeInsets.all(16),
                padding: EdgeInsets.all(16),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Logs',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                    ),
                    Icon(
                      FontAwesomeIcons.clipboardList
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.pushNamed(context, '/session');
          },
          tooltip: 'Start session',
          label: Text('Start session'),
          icon: Icon(Icons.play_arrow_rounded)),
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
