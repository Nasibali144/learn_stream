import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const StreamTwo());
}

class StreamTwo extends StatelessWidget {
  const StreamTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  final counter = Counter();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder<String>(
          initialData: "None",
          stream: counter.stream,
          builder: (context, snapshot) {
            return Text("Counter: ${snapshot.data}", style: Theme.of(context).textTheme.headlineLarge,);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: null,
      label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(onPressed: counter.increment, icon: const Icon(Icons.add)),
            IconButton(onPressed: counter.decrement, icon: const Icon(Icons.remove)),
          ],
        ),
      ),
    );
  }
}

class Counter {
  int count = 0;
  final StreamController<int> _controller = StreamController();

  final _transform = StreamTransformer<int, String>.fromHandlers(
    handleData: (data, sink) {
      sink.add(" $data");
    },
    handleError: (error, stackTrace, sink) {
      sink.add("Error ekanda");
    }
  );

  Stream<String> get stream => _transform.bind(_controller.stream);

  void increment() {
    if(count == 2) {
      count++;
      _controller.sink.addError("ERROR");
    } else {
      _controller.sink.add(++count);
    }
  }

  void decrement() {
    _controller.sink.add(--count);
  }
}
