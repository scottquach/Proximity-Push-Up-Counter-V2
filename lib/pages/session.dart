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
                              setState(() {
                                progress += 1;
                              });
                            },
                            child: Center(
                              child: Text(
                                '$progress',
                                style: TextStyle(fontSize: 164),
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
                ),
              ],
            ),
            ActionItems()
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () {
      //     Navigator.pushReplacementNamed(context, '/logs');
      //   },
      //   icon: Icon(Icons.stop),
      //   label: Text('End Session'),
      // ),
    );
  }
}

class ActionItems extends StatelessWidget {
  const ActionItems({
    Key key,
  }) : super(key: key);

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
                      child: Ink(
                        decoration: BoxDecoration(
                            color: Colors.grey[100],
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey[500])),
                        child: IconButton(
                          icon: Icon(Icons.replay),
                          onPressed: () {},
                          padding: EdgeInsets.all(16),
                        ),
                      ),
                    ),
                    Ink(
                      decoration: BoxDecoration(
                          color: Colors.grey[100],
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey[500])),
                      child: IconButton(
                        icon: Icon(Icons.exposure_minus_1),
                        onPressed: () {},
                        padding: EdgeInsets.all(16),
                      ),
                    ),
                  ],
                ),
                RaisedButton(
                  onPressed: () {},
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

class SessionTimer extends StatelessWidget {
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
              Text('00:00:00',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36)),
            ],
          ),
        ),
      ),
    );
  }
}
