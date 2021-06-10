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
            width: _extended ? 200 : null,
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
              trailing: Container(
                //constraints: const BoxConstraints(minWidth: double.infinity),
                margin: EdgeInsets.symmetric(vertical: 13, horizontal: 8),
                child: InkWell(
                  borderRadius: BorderRadius.circular(5000),
                  onTap: () {
                    _extended = !_extended;
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    //margin: EdgeInsets.all(10),
                    //width: 170,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5000),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        HeroIcon(
                          !_extended
                              ? HeroIcons.chevronRight
                              : HeroIcons.chevronLeft,
                          size: 30,
                          color: Theme.of(context).iconTheme.color,
                        ),
                        if (_extended)
                          SizedBox(
                            width: 10,
                          ),
                        if (_extended)
                          Text(
                            "Contract Menu",
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              color: Theme.of(context).iconTheme.color,
                            ),
                          ),
                        if (_extended)
                          SizedBox(
                            width: 5,
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
