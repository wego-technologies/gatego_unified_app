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

  Map<String, HeroIcons> _destinations = {
    "Flash Device": HeroIcons.chip,
    "Register Device": HeroIcons.plusCircle,
    "Test Device": HeroIcons.shieldCheck,
    "Factory Reset": HeroIcons.fire,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Container(
            width: 200,
            child: Menu(
              selectedItemKey: _selectedItemKey,
              menuItems: _destinations,
              leading: FlutterLogo(),
              expanded: _extended,
              onItemPressed: (item) {
                print(item);
                _selectedItemKey = item;
                setState(() {});
              },
              trailing: IconButton(
                icon: HeroIcon(HeroIcons.chevronRight),
                onPressed: () {
                  _extended = !_extended;
                  setState(() {});
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
