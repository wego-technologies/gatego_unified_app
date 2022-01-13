import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:gatego_unified_app/actions/factoryReset.dart';
import 'package:gatego_unified_app/actions/falsh.dart';
import 'package:gatego_unified_app/components/menu.dart';
import 'package:gatego_unified_app/molecules/UserCard.dart';
import 'package:gatego_unified_app/pages/comingSoon.dart';
import 'package:gatego_unified_app/pages/flash.dart';
import 'package:gatego_unified_app/pages/login.dart';
import 'package:gatego_unified_app/providers/commandStreamProvider.dart';
import 'package:heroicons/heroicons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() async {
  runApp(AppWrapper());
}

class AppWrapper extends StatelessWidget {
  final routerDelegate = BeamerDelegate(
    locationBuilder: RoutesLocationBuilder(
      routes: {
        // Return either Widgets or BeamPages if more customization is needed
        '/': (context, state, data) => const MenuWrapper(),
        '/login': (context, state, data) => const LoginPage(),
      },
    ),
  );

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp.router(
        title: 'Gatego Autonomous+ Tools',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: const Color(0xFF00ADE2),
          textTheme: GoogleFonts.robotoTextTheme(
            Theme.of(context).textTheme,
          ).apply(
            bodyColor: const Color(0xff353535),
            displayColor: const Color(0xff353535),
          ),
        ),
        routeInformationParser: BeamerParser(),
        routerDelegate: routerDelegate,
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
  final String _selectedItemKey = 'Flash Device';
  final bool _extended = false;

  final Map<String, HeroIcons> _destinations = {
    'Flash Device': HeroIcons.chip,
    'Register Device': HeroIcons.plusCircle,
    'Test Device': HeroIcons.shieldCheck,
    'Factory Reset': HeroIcons.fire,
  };

  @override
  Widget build(BuildContext context) {
    var _pages = <String, Widget>{
      'Flash Device': FlashPage(
        _extended,
        actions: flashActions,
        commandProvider: commandFlashProvider,
      ),
      'Register Device': const ComingSoonPage(),
      'Test Device': const ComingSoonPage(),
      'Factory Reset': FlashPage(
        _extended,
        actions: resetActions,
        button: 'Resetting',
        title: 'Reset',
        commandProvider: commandResetProvider,
      ),
    };

    return Scaffold(
      body: Row(
        children: [
          Container(
            width: _extended ? 232 : null,
            child: Consumer(
              builder: (context, watch, child) {
                return NavigationRail(
                  labelType: NavigationRailLabelType.selected,
                  destinations: _destinations
                      .map((key, value) {
                        return MapEntry(
                          key,
                          NavigationRailDestination(
                            icon: HeroIcon(value),
                            label: Text(key),
                          ),
                        );
                      })
                      .values
                      .toList(),
                  selectedIndex: 0,
                  onDestinationSelected: (index) {},
                );
              },
            ),
          ),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 150),
              child: _pages[_selectedItemKey] ?? const SizedBox(),
            ),
          ),
        ],
      ),
    );
  }
}
