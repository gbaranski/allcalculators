import 'package:allcalculators/shared/additional_screen_view.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

const String AdditionImagePath = 'assets/math/basic_arithmetic/addition';

class Addition extends StatelessWidget {
  final MathForm mathForm = MathForm(
      getResult: (inputs) {
        return inputs.reduce((a, b) => a + b);
      },
      iconBetween: Icons.add);

  @override
  Widget build(BuildContext context) {
    return AdditionalScreenView(
      mathForm: mathForm,
      title: "Addition",
      children: [
        Text(
          "Addition is one of the four basic operations of arithmetic.",
          style: TextStyle(fontSize: 14),
        ),
        Divider(),
        Text("For example 432344+238443 = 670787"),
      ],
    );
  }
}

class Subtraction extends StatelessWidget {
  final MathForm mathForm = MathForm(
      getResult: (inputs) {
        return inputs.reduce((a, b) => a - b);
      },
      iconBetween: MdiIcons.minus);

  @override
  Widget build(BuildContext context) {
    return AdditionalScreenView(
      mathForm: mathForm,
      title: "Subtraction",
      children: [
        Text(
          "Subtraction is one of the four basic operations of arithmetic.",
          style: TextStyle(fontSize: 14),
        ),
        Divider(),
        Text("For example 432344-238443 = 193901"),
      ],
    );
  }
}

class Multiplication extends StatelessWidget {
  final MathForm mathForm = MathForm(
      getResult: (inputs) {
        return inputs.reduce((a, b) => a * b);
      },
      iconBetween: MdiIcons.multiplication);

  @override
  Widget build(BuildContext context) {
    return AdditionalScreenView(
      mathForm: mathForm,
      title: "Multiplication",
      children: [
        Text(
          "Multiplication is one of the four basic operations of arithmetic.",
          style: TextStyle(fontSize: 14),
        ),
        Divider(),
        Text("For example 7*7 = 49"),
      ],
    );
  }
}

class Division extends StatelessWidget {
  final MathForm mathForm = MathForm(
      getResult: (inputs) {
        return inputs.reduce((a, b) => a / b);
      },
      iconBetween: MdiIcons.division);

  @override
  Widget build(BuildContext context) {
    return AdditionalScreenView(
      mathForm: mathForm,
      title: "Division",
      children: [
        Text(
          "Division is one of the four basic operations of arithmetic.",
          style: TextStyle(fontSize: 14),
        ),
        Divider(),
        Text(
            "For example 15 / 3 = 5, because we can fit number 3, 5 times in 15"),
      ],
    );
  }
}
