import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gatego_unified_app/components/SerialSelect.dart';
import 'package:gatego_unified_app/components/serialInfo.dart';
import 'package:gatego_unified_app/molecules/progessCard.dart';
import 'package:heroicons/heroicons.dart';
import 'package:loading_indicator/loading_indicator.dart';

class FlashPage extends StatelessWidget {
  final bool extended;

  FlashPage(this.extended);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width -
                      (extended ? 282 : 232),
                  child: Row(
                    children: [
                      Flexible(
                        child: SerialCard(),
                        flex: 5,
                      ),
                      Flexible(
                          child: Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: SerialInfo(),
                      ))
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                clipBehavior: Clip.antiAlias,
                margin: EdgeInsets.only(top: 30),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 15,
                      spreadRadius: 0,
                      color: Theme.of(context).shadowColor.withAlpha(20),
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 350,
                      padding: EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: ListView(
                              children: [
                                Text(
                                  "Progress",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                ProgressCard(
                                  state: ProgressCardState.pending,
                                  icon: HeroIcons.save,
                                  text: "Download Files",
                                ),
                                ProgressCard(
                                  state: ProgressCardState.pending,
                                  icon: HeroIcons.saveAs,
                                  text: "Download Tools",
                                ),
                                ProgressCard(
                                  state: ProgressCardState.pending,
                                  icon: HeroIcons.upload,
                                  text: "Install Firmware",
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Color(0xff00B633),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color(0xff00B633),
                                                blurRadius: 10,
                                                spreadRadius: 1.5,
                                              ),
                                            ]),
                                        padding: EdgeInsets.all(2),
                                        width: 20,
                                        height: 20,
                                        child: HeroIcon(
                                          HeroIcons.check,
                                          color: Colors.white,
                                          solid: false,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Text(
                                        "Complete",
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Theme.of(context)
                                              .disabledColor
                                              .withAlpha(150),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              style: ButtonStyle(
                                padding: MaterialStateProperty.resolveWith(
                                  (states) => EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 50),
                                ),
                                backgroundColor:
                                    MaterialStateProperty.resolveWith(
                                  (states) => Theme.of(context).primaryColor,
                                ),
                                shape: MaterialStateProperty.resolveWith(
                                  (states) => RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                              ),
                              onPressed: () {},
                              label: Icon(Icons.play_arrow_rounded),
                              icon: Text("Start Flashing"),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: Container(
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}