import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FlatButton(
          onPressed: () {
            Navigator.pushNamed(context, '/session');
          },
          child: Text('Start session'),
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
