import 'package:flutter/material.dart';

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

  List<NavigationRailDestination> _destinations = [
    NavigationRailDestination(
        icon: Icon(Icons.computer_rounded), label: Text("Flash Device")),
    NavigationRailDestination(
        icon: Icon(Icons.computer_rounded), label: Text("Flash Device")),
    NavigationRailDestination(
        icon: Icon(Icons.computer_rounded), label: Text("Flash Device")),
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
          NavigationRail(
            destinations: _destinations,
            selectedIndex: _selectedIndex,
            trailing: IconButton(
              icon: AnimatedIcon(
                icon: AnimatedIcons.list_view,
                progress: _animationController,
              ),
              onPressed: () {
                _extended = !_extended;
                if (_extended) {
                  _animationController.forward();
                } else {
                  _animationController.reverse();
                }
                setState(() {});
              },
            ),
            extended: _extended,
          ),
        ],
      ),
    );
  }
}
