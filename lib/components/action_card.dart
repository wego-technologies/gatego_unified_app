import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:gatego_unified_app/molecules/console.dart';
import 'package:gatego_unified_app/molecules/progess_card.dart';
import 'package:gatego_unified_app/providers/command_stream_provider.dart';
import 'package:gatego_unified_app/providers/serial_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ActionCard extends ConsumerStatefulWidget {
  final List<ActionItem> actions;
  final String buttonText;
  final Widget buttonIcon;
  final StateProvider<List<String>> commandProvider;

  const ActionCard({
    Key? key,
    required this.actions,
    required this.buttonIcon,
    required this.buttonText,
    required this.commandProvider,
  }) : super(key: key);

  @override
  _ActionCardState createState() => _ActionCardState();
}

class _ActionCardState extends ConsumerState<ActionCard> {
  var cont = ScrollController();
  int? progress;
  bool inP = false;
  int? failedIndex;

  @override
  void dispose() {
    cont.dispose();
    widget.actions.map((e) => e.state = ProgressCardState.pending).toList();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        clipBehavior: Clip.antiAlias,
        margin: const EdgeInsets.only(top: 30),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Theme.of(context).cardColor,
          ),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 350,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Consumer(builder: (context, ref, _) {
                    var commandList =
                        ref.watch(widget.commandProvider.state).state;
                    return Expanded(
                      child: ListView(
                        key: PageStorageKey(widget.buttonText + 'listView'),
                        padding: const EdgeInsets.all(20),
                        children: [
                          const Text(
                            'Progress',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w800,
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
                              e
                                  .doOnAction(
                                      context, ref, widget.commandProvider)
                                  .then((res) {
                                inP = false;
                                setStateProtected(() {
                                  if (res) {
                                    ref
                                        .read(widget.commandProvider.state)
                                        .state = [
                                      ...ref
                                          .read(widget.commandProvider.state)
                                          .state,
                                      ('> Completed ' + e.title)
                                    ];
                                    e.state = ProgressCardState.done;
                                  } else {
                                    ref
                                        .read(widget.commandProvider.state)
                                        .state = [
                                      ...ref
                                          .read(widget.commandProvider.state)
                                          .state,
                                      ('> Failed ' + e.title + ', halting')
                                    ];
                                    failedIndex = index;
                                    e.state = ProgressCardState.fail;
                                    progress = widget.actions.length;
                                  }

                                  if (progress != null &&
                                      progress != widget.actions.length) {
                                    progress = progress! + 1;
                                  }

                                  if (progress == widget.actions.length) {
                                    ref.read(inProgProvider.state).state =
                                        false;
                                  }
                                });
                              });
                            } else if (inP && progress == index) {
                              e.state = ProgressCardState.inProgress;
                            } else if (failedIndex != null &&
                                failedIndex! == index) {
                              e.state = ProgressCardState.fail;
                            } else if ((failedIndex != null &&
                                    failedIndex! > index) ||
                                (((progress ?? -1) >= index) &&
                                    failedIndex == null)) {
                              e.state = ProgressCardState.done;
                            }
                            return ProgressCard(
                              state: e.state ?? ProgressCardState.pending,
                              icon: Icon(
                                e.icon,
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? const Color.fromARGB(255, 240, 240, 240)
                                    : const Color.fromARGB(255, 78, 78, 78),
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
                              child: Icon(
                                failedIndex == null
                                    ? FluentSystemIcons
                                        .ic_fluent_checkmark_regular
                                    : FluentSystemIcons
                                        .ic_fluent_dismiss_regular,
                                color: Colors.white,
                                size: 15,
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  }),
                  Consumer(builder: (context, ref, _) {
                    var serial = ref.watch(serialProvider.state).state;
                    return Container(
                      padding: const EdgeInsets.all(20),
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        style: ButtonStyle(
                          padding: MaterialStateProperty.resolveWith(
                            (states) => const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 50),
                          ),
                          backgroundColor: MaterialStateProperty.resolveWith(
                            (states) {
                              if (states.contains(MaterialState.disabled)) {
                                return Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.5);
                              } else {
                                return Theme.of(context).primaryColor;
                              }
                            },
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
                                for (var element in widget.actions) {
                                  progress = 0;
                                  element.state = ProgressCardState.pending;
                                }
                                failedIndex = null;
                                ref.read(inProgProvider.state).state = true;
                                setStateProtected(() {});
                              },
                        label: const Icon(
                          FluentSystemIcons.ic_fluent_play_regular,
                          size: 15,
                        ),
                        icon: Text(widget.buttonText),
                      ),
                    );
                  }),
                ],
              ),
            ),
            Console(
              cont: cont,
              commandProvider: widget.commandProvider,
              key: Key(widget.buttonText + 'console'),
            ),
          ],
        ),
      ),
    );
  }

  void setStateProtected(void Function() fn) {
    if (mounted) {
      setState(fn);
    }
  }
}

// ignore: must_be_immutable
