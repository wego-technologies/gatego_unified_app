import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gatego_unified_app/components/SerialSelect.dart';
import 'package:gatego_unified_app/components/actionCard.dart';
import 'package:gatego_unified_app/components/serialInfo.dart';
import 'package:heroicons/heroicons.dart';

class FlashPage extends StatelessWidget {
  final bool extended;

  const FlashPage(this.extended);

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
                    children: const [
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
            ActionCard(
              actions: [
                ActionItem(
                  doOnAction: () async {
                    await Future.delayed(const Duration(seconds: 2));
                    return true;
                  },
                  icon: HeroIcons.download,
                  title: "Download Files",
                ),
                ActionItem(
                  doOnAction: () async {
                    await Future.delayed(const Duration(seconds: 2));
                    return true;
                  },
                  icon: HeroIcons.folderDownload,
                  title: "Download Tools",
                ),
                ActionItem(
                  doOnAction: () async {
                    await Future.delayed(const Duration(seconds: 2));
                    return true;
                  },
                  icon: HeroIcons.trash,
                  title: "Erase Chip",
                ),
                ActionItem(
                  doOnAction: () async {
                    await Future.delayed(const Duration(seconds: 2));
                    return true;
                  },
                  icon: HeroIcons.upload,
                  title: "Install Firmware",
                ),
              ],
              buttonIcon: const HeroIcon(HeroIcons.play),
              buttonText: "Start Flashing",
            ),
          ],
        ),
      ),
    );
  }
}
