import 'dart:async';

import 'package:flutter/material.dart';

class MinuteCounter extends StatefulWidget {
  final initialCount;

  MinuteCounter({@required this.initialCount});

  @override
  _MinuteCounterState createState() => _MinuteCounterState();
}

class _MinuteCounterState extends State<MinuteCounter> {
  var countStream = StreamController<int>();

  void initState() {
    countStream.add(0);
    Timer.periodic(Duration(seconds: 60), (Timer timer) {
      countStream.add(timer.tick);
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: countStream.stream,
      builder: (context, AsyncSnapshot<int> snapshot) {
        if (snapshot.hasData) {
          return Text("${widget.initialCount + snapshot.data}");
        }
        return Text("Loading");
      },
    );
  }
}
