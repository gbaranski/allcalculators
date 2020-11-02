import 'package:allcalculators/screens/math/views/basic_arithmetic.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter/material.dart';

enum MathDifficulty { easy, medium, hard }

class MathView {
  final Widget widget;
  final IconData iconData;
  final String title;
  // from 0 to 10
  final int difficulty;

  MathView(
      {@required this.widget,
      @required this.iconData,
      @required this.title,
      @required this.difficulty});
}

class MathViewGroup {
  final String title;
  final List<MathView> views;
  final IconData iconData;
  MathViewGroup(
      {@required this.title, @required this.views, @required this.iconData});
}

class MathScreen extends StatelessWidget {
  final List<MathViewGroup> mathViewGroups = [
    MathViewGroup(
      iconData: Icons.add,
      views: [
        MathView(
          widget: Addition(),
          iconData: Icons.add,
          title: "Addition",
          difficulty: 1,
        ),
        MathView(
          widget: Subtraction(),
          iconData: MdiIcons.minus,
          title: "Subtraction",
          difficulty: 1,
        ),
        MathView(
          widget: Multiplication(),
          iconData: MdiIcons.multiplication,
          title: "Multiplication",
          difficulty: 1,
        ),
        MathView(
          widget: Division(),
          iconData: MdiIcons.division,
          title: "Division",
          difficulty: 1,
        )
      ],
      title: "Basic arithmetic",
    ),
    MathViewGroup(iconData: MdiIcons.rulerSquare, title: "Geometry", views: []),
    MathViewGroup(iconData: MdiIcons.function, title: "Functions", views: []),
    MathViewGroup(
        iconData: MdiIcons.mathIntegral, title: "Integrals", views: []),
  ];

  Widget singleGroupView(BuildContext context, MathViewGroup view) {
    return Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: ExpansionTile(
          leading: Icon(view.iconData),
          title: Text(view.title),
          children: [
            GridView.count(
              shrinkWrap: true,
              padding: const EdgeInsets.all(20.0),
              childAspectRatio: MediaQuery.of(context).size.width /
                  (MediaQuery.of(context).size.height / 6),
              crossAxisCount: 2,
              children: view.views.map((subView) {
                return FlatButton.icon(
                  label: Text(subView.title),
                  icon: Icon(subView.iconData),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            settings: RouteSettings(
                                name: "math_${view.title}/${subView.title}"),
                            builder: (context) => subView.widget));
                  },
                );
              }).toList(),
            )
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics()
          .applyTo(BouncingScrollPhysics()),
      slivers: [
        SliverAppBar(
          title: Text("Math"),
        ),
        SliverList(
            delegate: SliverChildListDelegate(
          mathViewGroups
              .map((viewGroup) => singleGroupView(context, viewGroup))
              .toList(),
        ))
      ],
    );
  }
}
