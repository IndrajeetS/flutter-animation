import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';

class StopWatchScreen extends StatefulWidget {
  const StopWatchScreen({super.key});

  @override
  State<StopWatchScreen> createState() => _StopWatchScreenState();
}

class _StopWatchScreenState extends State<StopWatchScreen> {
  late Timer timer;

  int timerCount = 0;

  late dynamic newTimerWithMin;

  startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        timerCount = timerCount + 1;
      });
    });
  }

  pauseTimer() {
    log("Pause timer");
    timer.cancel();
  }

  resetTimer() {
    log("Reset timer");
    setState(() {
      timerCount = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    log(timerCount.runtimeType.toString());
    const sizedBoxWidget = SizedBox(width: 8.0);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Timer: $timerCount secs"),
          const SizedBox(height: 10),
          const SizedBox(
            width: 100,
            height: 100,
            child: Text("Square Container"),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: TextButton(
                  child: const Text("Start"),
                  onPressed: () {
                    startTimer();
                    log("$timerCount");
                  },
                ),
              ),
              sizedBoxWidget,
              Flexible(
                child: TextButton(
                  child: const Text("Pause"),
                  onPressed: () {
                    pauseTimer();
                  },
                ),
              ),
              sizedBoxWidget,
              Flexible(
                child: TextButton(
                  child: const Text("Reset"),
                  onPressed: () {
                    resetTimer();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}



// Text,-> time  
// Container
// Button, Pause, rest, 