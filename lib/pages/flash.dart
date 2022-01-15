import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gatego_unified_app/molecules/console.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../components/SerialSelect.dart';
import '../components/actionCard.dart';

class FlashPage extends StatelessWidget {
  final bool extended;
  final List<ActionItem> actions;
  final String title;
  final String button;
  final StateProvider<List<String>> commandProvider;

  const FlashPage(this.extended,
      {required this.actions,
      this.title = 'Flash',
      this.button = 'Flashing',
      required this.commandProvider,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 5,
                child: SerialCard(title),
              ),
            ],
          ),
          ActionCard(
            actions: actions,
            buttonIcon: const Icon(FluentSystemIcons.ic_fluent_play_filled),
            buttonText: 'Start $button',
            commandProvider: commandProvider,
            key: Key(title),
          ),
        ],
      ),
    );
  }
}
