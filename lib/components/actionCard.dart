import 'package:flutter/material.dart';
import 'package:gatego_unified_app/molecules/progessCard.dart';
import 'package:gatego_unified_app/providers/commandStreamProvider.dart';
import 'package:gatego_unified_app/providers/serialProvider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ActionCard extends StatefulWidget {
  final List<ActionItem> actions;
  final String buttonText;
  final Widget buttonIcon;

  const ActionCard({
    Key? key,
    required this.actions,
    required this.buttonIcon,
    required this.buttonText,
  }) : super(key: key);

  @override
  _ActionCardState createState() => _ActionCardState();
}

class _ActionCardState extends State<ActionCard> {
  int? progress;
  bool inP = false;
  int? failedIndex;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        clipBehavior: Clip.antiAlias,
        margin: const EdgeInsets.only(top: 30),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              blurRadius: 15,
              spreadRadius: 0,
              color: Theme.of(context).shadowColor.withAlpha(20),
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 350,
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Consumer(builder: (context, watch, _) {
                    var commandList = watch(commandProvider).state;
                    return Expanded(
                      child: ListView(
                        children: [
                          const Text(
                            'Progress',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          ...widget.actions.map((e) {
                            var index = widget.actions.indexOf(e);
                            if (index == progress && !inP) {
                              inP = true;
                              commandList.add('> Starting ' + e.title);
                              e.state = ProgressCardState.inProgress;
                              e.doOnAction(context, watch).then((res) {
                                inP = false;
                                setState(() {
                                  if (res) {
                                    commandList.add('> Completed ' + e.title);
                                    e.state = ProgressCardState.done;
                                  } else {
                                    commandList.add(
                                        '> Failed ' + e.title + ', halting');
                                    failedIndex = index;
                                    e.state = ProgressCardState.fail;
                                    progress = widget.actions.length;
                                  }

                                  if (progress != null &&
                                      progress != widget.actions.length) {
                                    progress = progress! + 1;
                                  }
                                });
                              });
                            } else if (failedIndex != null &&
                                failedIndex! == index) {
                              e.state = ProgressCardState.fail;
                            } else if (failedIndex != null &&
                                failedIndex! > index) {
                              e.state = ProgressCardState.done;
                            }
                            return ProgressCard(
                              state: e.state ?? ProgressCardState.pending,
                              icon: HeroIcon(
                                e.icon,
                                color: const Color(0xff353535),
                              ),
                              text: e.title,
                            );
                          }).toList(),
                          ProgressCard(
                            text: failedIndex == null ? 'Complete' : 'Failed',
                            showTrailing: false,
                            state: widget.actions.length == progress
                                ? ProgressCardState.inProgress
                                : ProgressCardState.pending,
                            icon: Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: failedIndex == null
                                      ? const Color(0xff00B633)
                                      : Theme.of(context).errorColor,
                                  boxShadow: [
                                    BoxShadow(
                                      color: failedIndex == null
                                          ? const Color(0xff00B633)
                                          : Theme.of(context).errorColor,
                                      blurRadius: 10,
                                      spreadRadius: 1.5,
                                    ),
                                  ]),
                              padding: const EdgeInsets.all(2),
                              width: 20,
                              height: 20,
                              child: HeroIcon(
                                failedIndex == null
                                    ? HeroIcons.check
                                    : HeroIcons.x,
                                color: Colors.white,
                                solid: false,
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  }),
                  Consumer(builder: (context, watch, _) {
                    var serial = watch(serialProvider).state;
                    return Container(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        style: ButtonStyle(
                          padding: MaterialStateProperty.resolveWith(
                            (states) => const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 50),
                          ),
                          backgroundColor: MaterialStateProperty.resolveWith(
                            (states) => Theme.of(context).primaryColor,
                          ),
                          shape: MaterialStateProperty.resolveWith(
                            (states) => RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                        onPressed: serial == null ||
                                (progress != null &&
                                    progress != widget.actions.length)
                            ? null
                            : () {
                                widget.actions.forEach((element) {
                                  progress = 0;
                                  element.state = ProgressCardState.pending;
                                });
                                failedIndex = null;
                                setState(() {});
                              },
                        label: const Icon(Icons.play_arrow_rounded),
                        icon: const Text('Start Flashing'),
                      ),
                    );
                  }),
                ],
              ),
            ),
            Console(),
          ],
        ),
      ),
    );
  }
}

class Console extends ConsumerWidget {
  // ignore: prefer_const_constructors_in_immutables
  Console({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    var commands = watch(commandProvider);
    return Flexible(
      child: Container(
        color: Colors.black87,
        padding: const EdgeInsets.all(20),
        child: Stack(
          children: [
            ListView.builder(
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    commands.state[index],
                    style: GoogleFonts.ubuntuMono(
                      color: Colors.white,
                    ),
                  ),
                );
              },
              itemCount: commands.state.length,
            ),
            Positioned(
              bottom: 1,
              right: 1,
              child: Tooltip(
                message: 'Clear',
                child: FloatingActionButton(
                  onPressed: () {
                    watch(commandProvider).state = [];
                  },
                  backgroundColor: Theme.of(context).primaryColor,
                  child: const HeroIcon(HeroIcons.trash),
                ),
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
  Future<bool> Function(BuildContext, ScopedReader) doOnAction;

  ActionItem({
    required this.doOnAction,
    required this.icon,
    required this.title,
    this.state,
  });
}
