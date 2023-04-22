import 'package:flutter/material.dart';
import 'package:playing_card_animation/playing_card_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: PlayingCardAnimation(
        colors: [
          Colors.red.shade800,
          Colors.teal.shade800,
          Colors.blueGrey.shade800,
        ],
      ),
    );
  }
}
