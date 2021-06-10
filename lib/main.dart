import 'package:flutter/material.dart';
import 'package:gatego_unified_app/components/menu.dart';
import 'package:gatego_unified_app/molecules/UserCard.dart';
import 'package:heroicons/heroicons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(AppWrapper());
}

class AppWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'Gatego Autonomous+ Tools',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: Color(0xFF00ADE2),
          textTheme: GoogleFonts.robotoTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        home: MenuWrapper(),
      ),
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
            width: _extended ? 232 : null,
            child: Menu(
                onExpandedToggle: () {
                  _extended = !_extended;
                  setState(() {});
                },
                selectedItemKey: _selectedItemKey,
                menuItems: _destinations,
                leading: _extended
                    ? Image.asset(
                        "assets/Gatego logo.png",
                        height: 50,
                        //fit: BoxFit.,
                      )
                    : Image.asset(
                        "assets/Blue Icon Circle.png",
                        height: 50,
                      ),
                expanded: _extended,
                onItemPressed: (item) {
                  print(item);
                  _selectedItemKey = item;
                  setState(() {});
                },
                trailing: UserCard(expanded: _extended)),
          ),
        ],
      ),
    );
  }
}
