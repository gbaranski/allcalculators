import 'package:allcalculators/screens/practice/practice.dart';
import 'package:flutter/material.dart';

enum QuestionViewStatus {
  correct,
  incorrect,
  time_elapsed,
}

class QuestionView extends StatefulWidget {
  final QuestionAnswer questionAnswer;
  final void Function(QuestionViewStatus valid) onSubmit;

  QuestionView({@required this.questionAnswer, @required this.onSubmit});

  @override
  _QuestionViewState createState() => _QuestionViewState();
}

class _QuestionViewState extends State<QuestionView> {
  int selectedAnwser;
  DateTime startDate;

  @override
  void initState() {
    startDate = DateTime.now();
    super.initState();
  }

  void onAnswerSubmit(int i) {
    if (selectedAnwser == null) {
      final newSelectedQA = widget.questionAnswer.answers[i];
      setState(() {
        selectedAnwser = i;
      });
      Future.delayed(Duration(milliseconds: 1500), () {
        widget.onSubmit(newSelectedQA.valid
            ? QuestionViewStatus.correct
            : QuestionViewStatus.incorrect);
        setState(() {
          selectedAnwser = null;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      delegate: SliverChildBuilderDelegate((context, i) {
        final Answer currentAnswer = widget.questionAnswer.answers[i];
        return Card(
          color: selectedAnwser != null
              ? selectedAnwser == i
                  ? currentAnswer.valid == true
                      ? Colors.green
                      : Colors.red
                  : currentAnswer.valid == true
                      ? Colors.green
                      : null
              : null,
          child: InkWell(
            onTap: () {
              onAnswerSubmit(i);
            },
            child: Container(
                alignment: Alignment.center,
                child: Text(
                  currentAnswer.text,
                  style: TextStyle(fontSize: 36),
                )),
          ),
        );
      }, childCount: 4),
    );
  }
}
