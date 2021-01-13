import 'package:flutter/material.dart';

class SessionPage extends StatefulWidget {
  @override
  _SessionPageState createState() => _SessionPageState();
}

class _SessionPageState extends State<SessionPage> {
  int progress = 0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
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
                        style: TextStyle(color: Colors.black.withOpacity(0.75)),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            progress += 1;
                          });
                        },
                        child: Center(
                          child: Text(
                            '$progress',
                            style: TextStyle(fontSize: 144),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 64,
                      onPressed: () {
                        setState(() {
                          if (progress > 0) {
                            progress -= 1;
                          }
                        });
                      },
                    )
                  ],
                ),
              ),
            )),
            Container(
              padding: EdgeInsets.fromLTRB(48, 24, 48, 24),
              height: 200,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Session Time'),
                      Text(
                        '00.00.00',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      RaisedButton(
                        onPressed: () {
                          setState(() {
                            progress = 0;
                          });
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                new BorderRadius.all(Radius.circular(8))),
                        child: Text('Reset'),
                        visualDensity: VisualDensity.compact,
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Today\'s Goal'),
                      Text(
                        '25',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushReplacementNamed(context, '/logs');
        },
        icon: Icon(Icons.stop),
        label: Text('End Session'),
      ),
    );
  }
}
