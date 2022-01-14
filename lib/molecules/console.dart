import 'package:flutter/material.dart';
import 'package:gatego_unified_app/molecules/progessCard.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Console extends ConsumerWidget {
  final ScrollController cont;
  final StateProvider<List<String>> commandProvider;

  // ignore: prefer_const_constructors_in_immutables
  Console({
    Key? key,
    required this.cont,
    required this.commandProvider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    updateConsole(cont);
    var commands = ref.watch(commandProvider.state);
    return Flexible(
      child: Container(
        color: Colors.black87,
        padding: const EdgeInsets.all(20),
        child: Stack(
          children: [
            commands.state.isNotEmpty
                ? ListView.builder(
                    controller: cont,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: SelectableText(
                          commands.state[index],
                          style: GoogleFonts.ubuntuMono(
                            color: Colors.white,
                          ),
                        ),
                      );
                    },
                    itemCount: commands.state.length,
                  )
                : Container(
                    width: double.infinity,
                    height: double.infinity,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const HeroIcon(
                          HeroIcons.sparkles,
                          color: Colors.grey,
                          size: 100,
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Text(
                          'Nothing to see here ...',
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
            if (commands.state.isNotEmpty)
              Positioned(
                bottom: 1,
                right: 1,
                child: FloatingActionButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  tooltip: 'Clear',
                  onPressed: () {
                    ref.watch(commandProvider.state).state = [];
                  },
                  backgroundColor: Theme.of(context).primaryColor,
                  child: const HeroIcon(HeroIcons.trash),
                ),
              )
          ],
        ),
      ),
    );
  }
}

class ActionItem {
  String title;
  HeroIcons icon;
  ProgressCardState? state;
  Future<bool> Function(BuildContext, WidgetRef, StateProvider<List<String>>)
      doOnAction;

  ActionItem({
    required this.doOnAction,
    required this.icon,
    required this.title,
    this.state,
  });
}

Future<void> updateConsole(ScrollController cont) async {
  await Future.delayed(const Duration(seconds: 0));
  if (cont.hasClients) {
    await cont.animateTo(
      cont.position.maxScrollExtent,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOutCubic,
    );
  }
}
