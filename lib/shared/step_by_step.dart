import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

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
            physics: const AlwaysScrollableScrollPhysics()
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
