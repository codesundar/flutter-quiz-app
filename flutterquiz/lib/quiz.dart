import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  var questions = [];
  int index = 0;

  int rightAnswerCount = 0;
  int wrongAnswerCount = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.fetchQuestion();
  }

  fetchQuestion() {
    http.get("http://192.168.1.3:8080/questions.json").then((res) {
      var resp = jsonDecode(res.body);
      setState(() {
        questions = resp["questions"];
      });
    }).catchError((err) {
      print(err);
    });
  }

  validate(i) {
    if (questions[index]["answerIndex"] == i) {
      setState(() {
        rightAnswerCount++;
      });
    } else {
      setState(() {
        wrongAnswerCount++;
      });
    }

    if (index < questions.length - 1) {
      setState(() {
        index++;
      });
    } else {
      Navigator.pushNamed(context, '/result', arguments: {
        'right': rightAnswerCount,
        'wrong': rightAnswerCount,
        'total': questions.length
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: questions.length != 0
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    questions[index]["question"],
                    style: TextStyle(fontSize: 24),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  RaisedButton(
                    onPressed: () => validate(0),
                    child: Text(questions[index]["options"][0]),
                  ),
                  RaisedButton(
                    onPressed: () => validate(1),
                    child: Text(questions[index]["options"][1]),
                  ),
                  RaisedButton(
                    onPressed: () => validate(2),
                    child: Text(questions[index]["options"][2]),
                  ),
                  RaisedButton(
                    onPressed: () => validate(3),
                    child: Text(questions[index]["options"][3]),
                  ),
                ],
              ),
            )
          : Container(),
    );
  }
}
