import 'package:final_07600442/pages/world_cup_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const WorldCupPage(),
    );
  }
}

class Palette {
  static const MaterialColor myColor = const MaterialColor(
    0xff8b2030,
    const <int, Color>{
      50: const Color(0xff7d1d2b), //10%
      },
  );
}
