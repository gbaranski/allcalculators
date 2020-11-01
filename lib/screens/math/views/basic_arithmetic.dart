import 'dart:math';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MathForm {
  final num Function(List<num> inputs) getResult;
  List<num> inputs = [Random().nextInt(200), Random().nextInt(200)];
  String result;
  IconData iconBetween;

  MathForm({@required this.getResult, @required this.iconBetween});
}

class AdditionalScreenView extends StatefulWidget {
  final List<Widget> children;
  final String title;
  final MathForm mathForm;

  AdditionalScreenView(
      {@required this.children, @required this.title, this.mathForm});

  @override
  _AdditionalScreenViewState createState() => _AdditionalScreenViewState();
}

class _AdditionalScreenViewState extends State<AdditionalScreenView> {
  @override
  void initState() {
    super.initState();
    if (widget.mathForm != null) {
      setState(() {
        widget.mathForm.result =
            widget.mathForm.getResult(widget.mathForm.inputs).toString();
      });
    }
  }

  Widget singleInputItem(BuildContext context, int index) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      child: TextFormField(
        onChanged: (String value) {
          try {
            final num parsedNumber = num.parse(value);
            setState(() {
              widget.mathForm.inputs[index] = parsedNumber;
              widget.mathForm.result =
                  widget.mathForm.getResult(widget.mathForm.inputs).toString();
            });
          } catch (e) {
            setState(() {
              widget.mathForm.result = "Invalid";
            });
          }
        },
        initialValue: widget.mathForm.inputs[index].toString(),
        decoration: InputDecoration(
            labelText: "Enter any number",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            )),
        keyboardType: TextInputType.number,
      ),
    );
  }

  List<Widget> form(BuildContext context) {
    return [
      SliverList(
          delegate: SliverChildListDelegate(
        [
          singleInputItem(context, 0),
          Icon(Icons.add),
          singleInputItem(context, 1)
        ],
      )),
      SliverToBoxAdapter(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              MdiIcons.equal,
              size: 36,
            ),
            Text(
              widget.mathForm.result.toString(),
              style: TextStyle(fontSize: 26),
            ),
          ],
        ),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics:
            AlwaysScrollableScrollPhysics().applyTo(BouncingScrollPhysics()),
        slivers: [
          SliverAppBar(
            title: Text(widget.title),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.all(30),
              child: Column(
                children: widget.children,
              ),
            ),
          ),
          if (widget.mathForm != null) ...form(context),
        ],
      ),
    );
  }
}

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
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => StepByStepSolution(
                          steps: [
                            Step(
                              key: 1,
                              image: AssetImage('$AdditionImagePath/step1.png'),
                              explanation: "Some explanation 1",
                            ),
                            Step(
                                key: 2,
                                image:
                                    AssetImage('$AdditionImagePath/step2.png'),
                                explanation: "Some explanation 2"),
                            Step(
                                key: 3,
                                image:
                                    AssetImage('$AdditionImagePath/step3.png'),
                                explanation: "Some explanation 3"),
                            Step(
                                key: 4,
                                image:
                                    AssetImage('$AdditionImagePath/step4.png'),
                                explanation: "Some explanation 4"),
                            Step(
                                key: 5,
                                image:
                                    AssetImage('$AdditionImagePath/step5.png'),
                                explanation: "Some explanation 5"),
                            Step(
                                key: 6,
                                image:
                                    AssetImage('$AdditionImagePath/step6.png'),
                                explanation: "Some explanation 6"),
                            Step(
                                key: 7,
                                image:
                                    AssetImage('$AdditionImagePath/step7.png'),
                                explanation: "Some explanation 7"),
                          ],
                        ),
                    settings: RouteSettings(name: "math/addition/stepbystep")));
          },
          child: Text(
            "Show step by step",
            style: TextStyle(color: Colors.blue),
          ),
        ),
      ],
    );
  }
}

class StepByStepSolution extends StatefulWidget {
  final List<Step> steps;

  StepByStepSolution({@required this.steps});

  @override
  _StepByStepSolutionState createState() => _StepByStepSolutionState();
}

class Step {
  final AssetImage image;
  final String explanation;
  final int key;

  Step({@required this.image, @required this.explanation, @required this.key});
}

class _StepByStepSolutionState extends State<StepByStepSolution> {
  CarouselController buttonCarouselController = CarouselController();

  @override
  void initState() {
    widget.steps.sort((a, b) => a.key - b.key);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
            physics: AlwaysScrollableScrollPhysics()
                .applyTo(BouncingScrollPhysics()),
            slivers: [
          SliverAppBar(),
          SliverList(
            delegate: SliverChildListDelegate([
              Text("Explaination"),
              CarouselSlider(
                carouselController: buttonCarouselController,
                options:
                    CarouselOptions(height: 400.0, enableInfiniteScroll: false),
                items: widget.steps.map((step) {
                  return Image(image: step.image);
                }).toList(),
              ),
            ]),
          )
        ]));
  }
}
