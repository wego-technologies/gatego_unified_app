import 'package:flutter/material.dart';
import 'package:gatego_unified_app/molecules/progessCard.dart';
import 'package:gatego_unified_app/providers/commandStreamProvider.dart';
import 'package:gatego_unified_app/providers/serialProvider.dart';
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
                    var stream = watch(commandStreamProvider).state;
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
                            var prog = ProgressCardState.pending;
                            if (widget.actions.indexOf(e) == progress) {
                              prog = ProgressCardState.inProgress;
                              stream.add(stream.stream);
                              e.doOnAction().then((_) {
                                setState(() {
                                  stream.add('Complete ' + e.title);
                                  if (progress != null &&
                                      progress != widget.actions.length) {
                                    progress = progress! + 1;
                                  }
                                });
                              });
                            } else if (widget.actions.indexOf(e) <
                                (progress ?? 0)) {
                              prog = ProgressCardState.done;
                            }
                            return ProgressCard(
                              state: prog,
                              icon: HeroIcon(
                                e.icon,
                                color: const Color(0xff353535),
                              ),
                              text: e.title,
                            );
                          }).toList(),
                          ProgressCard(
                            text: 'Complete',
                            showTrailing: false,
                            state: widget.actions.length == progress
                                ? ProgressCardState.inProgress
                                : ProgressCardState.pending,
                            icon: Container(
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xff00B633),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0xff00B633),
                                      blurRadius: 10,
                                      spreadRadius: 1.5,
                                    ),
                                  ]),
                              padding: const EdgeInsets.all(2),
                              width: 20,
                              height: 20,
                              child: const HeroIcon(
                                HeroIcons.check,
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
                                  setState(() {
                                    progress = 0;
                                  });
                                });
                              },
                        label: const Icon(Icons.play_arrow_rounded),
                        icon: const Text('Start Flashing'),
                      ),
                    );
                  }),
                ],
              ),
            ),
            Flexible(
              child: Container(
                color: Colors.black87,
                child: Consumer(
                  builder: (context, watch, child) {
                    return StreamBuilder<List<String>>(
                      stream: watch(commandStreamProvider).state.stream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Expanded(
                            child: ListView.builder(
                              itemBuilder: (context, index) {
                                return Text(
                                  snapshot.data![index],
                                  style: TextStyle(color: Colors.white),
                                );
                              },
                              itemCount: snapshot.data!.length,
                            ),
                          );
                        } else {
                          return const SizedBox.expand();
                        }
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ActionItem {
  String title;
  HeroIcons icon;
  Future<bool> Function() doOnAction;

  ActionItem({
    required this.doOnAction,
    required this.icon,
    required this.title,
  });
}
