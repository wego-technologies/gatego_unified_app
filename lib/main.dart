import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

void main() {
  runApp(AppWrapper());
}

class AppWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gatego Autonomous+ Tools',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Color(0xFF00ADE2),
      ),
      home: MenuWrapper(),
    );
  }
}

class MenuWrapper extends StatefulWidget {
  const MenuWrapper({Key? key}) : super(key: key);

  @override
  _MenuWrapperState createState() => _MenuWrapperState();
}

class _MenuWrapperState extends State<MenuWrapper>
    with TickerProviderStateMixin {
  int _selectedIndex = 0;
  bool _extended = false;

  List<Widget> _destinations = [
    IconButton(
      onPressed: () {},
      icon: HeroIcon(HeroIcons.chip),
    ),
    IconButton(
      onPressed: () {},
      icon: HeroIcon(HeroIcons.plusCircle),
    ),
    IconButton(
      onPressed: () {},
      icon: HeroIcon(HeroIcons.puzzle),
    ),
    IconButton(
      onPressed: () {},
      icon: HeroIcon(HeroIcons.fire),
    ),
  ];

  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Column(
            children: [
              ..._destinations,
            ],
          ),
        ],
      ),
    );
  }
}
