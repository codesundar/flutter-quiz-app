import 'package:flutter/material.dart';
import 'package:flutterquiz/quiz.dart';
import 'package:flutterquiz/result.dart';
import 'package:flutterquiz/welcome.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WelcomePage(),
      routes: {
        '/quiz': (context) => QuizPage(),
        '/result': (context) => ResultPage()
      },
    );
  }
}
