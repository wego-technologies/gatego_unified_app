import 'package:flutter/material.dart';
import 'package:gatego_unified_app/components/menu.dart';
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
  String _selectedItemKey = "Flash Device";
  bool _extended = false;

  Map<String, Widget> _destinations = {
    "Flash Device": HeroIcon(HeroIcons.chip),
    "Register Device": HeroIcon(HeroIcons.plusCircle),
    "Test Device": HeroIcon(HeroIcons.shieldCheck),
    "Factory Reset": HeroIcon(HeroIcons.fire),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Menu(
        selectedItemKey: _selectedItemKey,
        menuItems: _destinations,
        leading: FlutterLogo(),
        onItemPressed: (item) {
          print(item);
        },
        trailing: FlutterLogo(),
      ),
    );
  }
}
