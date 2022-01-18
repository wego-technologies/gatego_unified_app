// ignore_for_file: unawaited_futures

import 'dart:io';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';
import 'package:gatego_unified_app/actions/factoryReset.dart';
import 'package:gatego_unified_app/actions/falsh.dart';
import 'package:gatego_unified_app/components/menu.dart';
import 'package:gatego_unified_app/molecules/UserCard.dart';
import 'package:gatego_unified_app/pages/comingSoon.dart';
import 'package:gatego_unified_app/pages/flash.dart';
import 'package:gatego_unified_app/providers/commandStreamProvider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Window.initialize();
  await windowManager.ensureInitialized();
  windowManager.setMinimumSize(const Size(970, 600));
  windowManager.setSize(const Size(970, 600));
  runApp(AppWrapper());
}

class AppWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'Gatego Autonomous+ Tools',
        theme: ThemeData(
          cardColor: ThemeData().cardColor.withAlpha(180),
          primarySwatch: Colors.blue,
          primaryColor: const Color(0xFF00ADE2),
          textTheme: GoogleFonts.robotoTextTheme(
            Theme.of(context).textTheme,
          ).apply(
            bodyColor: const Color(0xff353535),
            displayColor: const Color(0xff353535),
          ),
        ),
        darkTheme: ThemeData.dark().copyWith(
          cardColor: ThemeData.dark().cardColor.withAlpha(150),
          primaryColor: const Color(0xFF00ADE2),
        ),
        themeMode: ThemeMode.system,
        home: const MenuWrapper(),
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
  String _selectedItemKey = 'Flash';
  bool _extended = false;

  final Map<String, IconData> _destinations = {
    'Flash': FluentSystemIcons.ic_fluent_usb_port_regular,
    'Reset': FluentSystemIcons.ic_fluent_arrow_sync_circle_regular,
    'Register': FluentSystemIcons.ic_fluent_add_circle_regular,
    'Test': FluentSystemIcons.ic_fluent_shield_regular,
  };

  @override
  void didChangeDependencies() {
    if (Platform.isWindows) {
      print('Is W');

      final buildNum = Platform.operatingSystemVersion
          .split('(')
          .last
          .replaceAll('Build', '')
          .replaceAll(')', '')
          .trim();
      if (int.parse(buildNum) >= 22000) {
        //Windows 11
        print('W11');
        Window.setEffect(
          effect: WindowEffect.mica,
          dark: Theme.of(context).brightness == Brightness.dark,
        );
      } else {
        print('W10');
        Window.setEffect(
          effect: WindowEffect.aero,
          color: Theme.of(context).canvasColor.withOpacity(0.95),
          //dark: Theme.of(context).brightness == Brightness.dark,
        );
      }
    } else if (Platform.isLinux) {
      Window.setEffect(
        effect: WindowEffect.transparent,
        color: Theme.of(context).canvasColor.withOpacity(0.95),
        //dark: Theme.of(context).brightness == Brightness.dark,
      );
    } else if (Platform.isMacOS) {
      Window.setEffect(
        effect: WindowEffect.sidebar,
        //color: Theme.of(context).canvasColor.withOpacity(0.95),
        //dark: Theme.of(context).brightness == Brightness.dark,
      );
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var _pages = <String, Widget>{
      'Flash': FlashPage(
        _extended,
        actions: flashActions,
        commandProvider: commandFlashProvider,
      ),
      'Register': const ComingSoonPage(),
      'Test': const ComingSoonPage(),
      'Reset': FlashPage(
        _extended,
        actions: resetActions,
        button: 'Resetting',
        title: 'Reset',
        commandProvider: commandResetProvider,
      ),
    };

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Row(
        children: [
          Container(
            width: _extended ? 232 : null,
            child: Consumer(
              builder: (context, ref, child) {
                return Menu(
                  onExpandedToggle: () {
                    _extended = !_extended;
                    setState(() {});
                  },
                  trailing: UserCard(
                    expanded: _extended,
                  ),
                  selectedItemKey: _selectedItemKey,
                  menuItems: _destinations,
                  /*leading: _extended
                      ? Image.asset(
                          'assets/Gatego logo.png',
                          height: 50,
                          //fit: BoxFit.,
                        )
                      : Image.asset(
                          'assets/Blue Icon Circle.png',
                          height: 50,
                        ),*/
                  expanded: _extended,
                  onItemPressed: !ref.watch(inProgProvider)
                      ? (item) {
                          if (ref.read(inProgProvider)) {
                            print('In P');
                          } else {
                            _selectedItemKey = item;
                            setState(() {});
                          }
                        }
                      : null,
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
