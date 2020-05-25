import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'QuestionBank.dart';

void main() => runApp(MyApp());

QuestionBank questions = new QuestionBank();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        appBar: AppBar(
          backgroundColor: Colors.red.shade900,
          title: Text('Quiz'),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Widget> progress = [];

  int userCorrectAnswerCount = 0;

  void checkAnswer(bool userAnswer) {
    setState(() {
      if (userAnswer == questions.getAnswer()) {
        progress.add(Icon(
          Icons.check,
          color: Colors.green,
        ));
        ++userCorrectAnswerCount;
      } else {
        progress.add(Icon(
          Icons.close,
          color: Colors.red.shade900,
        ));
      }
      if (!questions.moveToNextQuestion()) {
        Alert(
          context: context,
          title: 'Finished!',
          desc:
              'You\'ve Scored $userCorrectAnswerCount out of ${questions.getSize()}',
        ).show();
        questions.reset();
        progress = [];
        userCorrectAnswerCount = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                questions.getQuestion(),
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
                textColor: Colors.white,
                color: Colors.green,
                child: Text(
                  'True',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
                onPressed: () {
                  checkAnswer(true);
                }),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red,
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                checkAnswer(false);
              },
            ),
          ),
        ),
        Row(
          children: progress,
        )
      ],
    );
  }
}
