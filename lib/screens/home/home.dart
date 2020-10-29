import 'package:allcalculators/screens/math/math.dart';
import 'package:allcalculators/screens/welcome/welcome.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class CustomScreen {
  final Widget widget;
  final IconData iconData;
  final String title;
  CustomScreen(
      {@required this.widget, @required this.iconData, @required this.title});
}

class _HomeState extends State<Home> {
  final List<CustomScreen> screens = [
    CustomScreen(
        widget: WelcomeScreen(),
        iconData: Icons.emoji_people,
        title: "Welcome"),
    CustomScreen(
        widget: MathScreen(), iconData: Icons.calculate, title: "Math"),
  ];

  int currentPage = 0;

  Widget renderScreen(BuildContext context) {
    return screens[currentPage].widget;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: renderScreen(context),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FlutterLogo(
                    size: 74,
                  ),
                  // Text(
                  //   "Allcalculators",
                  //   style: TextStyle(color: Colors.white, fontSize: 24),
                  // ),
                ],
              ),
              decoration: BoxDecoration(color: Color(0xFF9c47ff)),
            ),
            ...screens.asMap().entries.map((screen) {
              final selected = screen.key == currentPage;
              return ListTile(
                title: Text(
                  screen.value.title,
                  style: TextStyle(
                      color: selected ? Color(0xFF661FFF) : Colors.black),
                ),
                leading: Icon(
                  screen.value.iconData,
                  color: selected ? Color(0xFF661FFF) : Colors.black45,
                ),
                selected: selected,
                selectedTileColor: Color(0xFF661FFF).withOpacity(0.12),
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    currentPage = screen.key;
                  });
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
