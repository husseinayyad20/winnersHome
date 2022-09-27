import 'dart:async';

import 'package:flutter/material.dart';

class TimeWidget extends StatefulWidget {
  final int startTme;
  @override
  const TimeWidget(this.startTme, {Key? key}) : super(key: key);
  @override
  _TimeWidgetState createState() => _TimeWidgetState();
}

class _TimeWidgetState extends State<TimeWidget> {
  var timerVal = 0;
  Timer? _timer;
  String get _timerText {
    const secondsPerMinute = 60;
    final secondsLeft = timerVal;

    final formattedMinutesLeft =
        (secondsLeft ~/ secondsPerMinute).toString().padLeft(2, '0');
    final formattedSecondsLeft =
        (secondsLeft % secondsPerMinute).toString().padLeft(2, '0');

    return '$formattedMinutesLeft : $formattedSecondsLeft';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    timerVal = widget.startTme;
    _startTimer();
    super.initState();
  }

  void _startTimer() {
    const duration = Duration(seconds: 1);
    _timer = Timer.periodic(duration, (Timer timer) {
      setState(() {
        timerVal += 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Text(_timerText),
    );
  }
}
