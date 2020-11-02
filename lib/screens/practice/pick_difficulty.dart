import 'package:allcalculators/screens/math/math.dart';
import 'package:flutter/material.dart';

class PickDifficulty extends StatefulWidget {
  final Function(MathDifficulty) onPicked;
  PickDifficulty({@required this.onPicked});

  @override
  _PickDifficultyState createState() => _PickDifficultyState();
}

class _PickDifficultyState extends State<PickDifficulty>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);

    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SliverFadeTransition(
      opacity: animation,
      sliver: SliverList(
          delegate: SliverChildBuilderDelegate((context, i) {
        if (i == 0) {
          return Container(
            margin: const EdgeInsets.all(15),
            child: Text(
              "Pick difficulty",
              style: TextStyle(fontSize: 26),
            ),
            alignment: Alignment.center,
          );
        }
        final currentMathDifficulty = MathDifficulty.values[i - 1];
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          height: 100,
          child: RaisedButton(
            onPressed: () {
              controller.reverse().whenComplete(() {
                widget.onPicked(currentMathDifficulty);
              });
            },
            color: currentMathDifficulty == MathDifficulty.easy
                ? Colors.green
                : currentMathDifficulty == MathDifficulty.medium
                    ? Colors.orange
                    : currentMathDifficulty == MathDifficulty.hard
                        ? Colors.red
                        : null,
            textColor: Colors.white,
            child: Text(
              currentMathDifficulty == MathDifficulty.easy
                  ? "EASY"
                  : currentMathDifficulty == MathDifficulty.medium
                      ? "MEDIUM"
                      : currentMathDifficulty == MathDifficulty.hard
                          ? "HARD"
                          : null,
              style: TextStyle(fontSize: 24),
            ),
          ),
        );
      }, childCount: MathDifficulty.values.length + 1)),
    );
  }
}
