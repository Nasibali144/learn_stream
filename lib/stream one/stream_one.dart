import 'dart:async';

import 'package:flutter/material.dart';

Stream<int> naturalGenerator(int n) async* {
  int k = 0;

  while (k < n) {
    k++;
    print(k);
    await Future.delayed(const Duration(seconds: 1));

    if (k == 4) {
      yield* Stream<int>.error('error: $k');
    } else {
      yield k;
    }
  }
}

void main() {
  runApp(const LearnStream());
}

class LearnStream extends StatelessWidget {
  const LearnStream({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.light,
      theme: ThemeData.light(useMaterial3: true),
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int number = 0;
  StreamSubscription<int>? subscriber;
   Stream<int>? stream;

  @override
  void initState() {
    super.initState();
    stream = naturalGenerator(10).asBroadcastStream();
    subscriber = stream?.listen(null);

    subscriber?.onData((data) {
      setState(() {
        number = data;
      });
    });

    subscriber?.onError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text("Error: $error"),
        ),
      );
    });

    subscriber?.onDone(() {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text("Tamam"),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "data: $number",
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if(subscriber!.isPaused) {
            subscriber!.resume();
          } else {
            subscriber!.pause();
          }
          setState(() {});
        },
        child:  Icon(subscriber!.isPaused ? Icons.play_arrow : Icons.stop),
      ),
    );
  }

  @override
  void dispose() {
    subscriber!.cancel();
    super.dispose();
  }
}
