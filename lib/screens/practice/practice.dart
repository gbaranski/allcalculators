import 'dart:async';

import 'package:allcalculators/screens/math/math.dart';
import 'package:allcalculators/screens/practice/pick_difficulty.dart';
import 'package:allcalculators/screens/practice/question.dart';
import 'package:flutter/material.dart';

class Answer {
  final bool valid;
  final String text;

  Answer({@required this.valid, @required this.text});
}

class QuestionAnswer {
  final String questionText;
  final List<Answer> answers;
  final Duration timeToAnswer;

  QuestionAnswer(
      {@required this.questionText,
      this.timeToAnswer = const Duration(seconds: 10),
      @required this.answers});
}

class Practice {
  // difficulty from 0 to 10
  final QuestionAnswer Function(MathDifficulty difficulty) getQuestionAnswer;

  Practice({@required this.getQuestionAnswer});
}

class PracticeView extends StatefulWidget {
  final Practice practice;

  PracticeView({@required this.practice});

  @override
  _PracticeViewState createState() => _PracticeViewState();
}

class _PracticeViewState extends State<PracticeView>
    with SingleTickerProviderStateMixin {
  MathDifficulty selectedDifficulty;
  QuestionAnswer currentQuestionAnswer;
  AnimationController controller;
  Animation<double> animation;

  void start(MathDifficulty mathDifficulty) {
    setState(() {
      selectedDifficulty = mathDifficulty;
      currentQuestionAnswer =
          widget.practice.getQuestionAnswer(selectedDifficulty);
    });
    controller.forward();
  }

  void onQuestionSubmit(QuestionViewStatus questionViewStatus) {
    controller.reverse().whenComplete(() {
      setState(() {
        currentQuestionAnswer =
            widget.practice.getQuestionAnswer(selectedDifficulty);
      });
      controller.forward();
    });
  }

  @override
  void initState() {
    controller = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics()
            .applyTo(BouncingScrollPhysics()),
        slivers: [
          SliverAppBar(
            title: Text("Practice"),
          ),
          if (selectedDifficulty == null) (PickDifficulty(onPicked: start)),
          if (selectedDifficulty != null) ...[
            SliverFadeTransition(
              opacity: animation,
              sliver: SliverToBoxAdapter(
                child: Container(
                    margin: EdgeInsets.all(25),
                    alignment: Alignment.center,
                    child: Text(
                      currentQuestionAnswer.questionText,
                      style: TextStyle(fontSize: 26),
                    )),
              ),
            ),
            if (currentQuestionAnswer != null)
              SliverFadeTransition(
                opacity: animation,
                sliver: (QuestionView(
                    questionAnswer: currentQuestionAnswer,
                    onSubmit: onQuestionSubmit)),
              )
          ]
        ],
      ),
    );
  }
}
