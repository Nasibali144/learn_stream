import 'package:flutter/material.dart';
import 'package:learn_stream/stream%20three/screen/home.dart';

class ShopApp extends StatelessWidget {
  const ShopApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.light,
      theme: ThemeData.light(useMaterial3: true),
      home: Home(),
    );
  }
}
