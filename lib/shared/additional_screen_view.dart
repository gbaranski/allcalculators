import 'dart:math';

import 'package:flutter/material.dart';
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
          Icon(widget.mathForm.iconBetween),
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
