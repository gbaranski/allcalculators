import 'package:allcalculators/screens/math/views/addition.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter/material.dart';

enum MathDifficulty { easy, medium, hard }

class MathView {
  final Widget widget;
  final IconData iconData;
  final String title;
  final MathDifficulty difficulty;

  MathView(
      {@required this.widget,
      @required this.iconData,
      @required this.title,
      @required this.difficulty});
}

class MathScreen extends StatelessWidget {
  final List<MathView> mathViews = [
    MathView(
      widget: MathAdditionView(),
      iconData: Icons.add,
      title: "Basic arithmetic",
      difficulty: MathDifficulty.easy,
    ),
    MathView(
      widget: MathAdditionView(),
      iconData: MdiIcons.rulerSquare,
      title: "Geometry",
      difficulty: MathDifficulty.easy,
    ),
    MathView(
      widget: MathAdditionView(),
      iconData: MdiIcons.function,
      title: "Functions",
      difficulty: MathDifficulty.medium,
    ),
    MathView(
      widget: MathAdditionView(),
      iconData: MdiIcons.mathIntegral,
      title: "Integrals",
      difficulty: MathDifficulty.hard,
    ),
  ];

  Widget singleGroupView(BuildContext context, MathView view) {
    return Card(
        elevation: 0,
        color: view.difficulty == MathDifficulty.easy
            ? Colors.green
            : view.difficulty == MathDifficulty.medium
                ? Colors.orange
                : view.difficulty == MathDifficulty.hard
                    ? Colors.red
                    : Colors.blueGrey,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () {},
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  view.title,
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
                Icon(
                  view.iconData,
                  size: 36,
                ),
              ],
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: AlwaysScrollableScrollPhysics().applyTo(BouncingScrollPhysics()),
      slivers: [
        SliverAppBar(),
        SliverGrid(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 180, childAspectRatio: 1.4),
            delegate: SliverChildListDelegate(
              mathViews
                  .map((viewGroup) => singleGroupView(context, viewGroup))
                  .toList(),
            ))
      ],
    );
  }
}
