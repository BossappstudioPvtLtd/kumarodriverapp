import 'package:flutter/material.dart';
import 'package:flutter_flip_clock/flutter_flip_clock.dart';



class MyApp1 extends StatefulWidget {
  const MyApp1({super.key});

  @override
  State<MyApp1> createState() => _MyApp1State();
}

class _MyApp1State extends State<MyApp1> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter flip clock'),
        ),
        body: Center(
          child: SizedBox(
            height: 150,
            child: FlipClock.simple(
              height: 40.0,
              width: 40.0,
              digitColor: Colors.white,
              backgroundColor: Colors.black,
              digitSize: 14.0,
              borderRadius: const BorderRadius.all(Radius.circular(3.0)),
              startTime: DateTime(2033, 12, 12),
              timeLeft: const Duration(minutes: 1),
            ),
          ),
        ),
      ),
    );
  }
}