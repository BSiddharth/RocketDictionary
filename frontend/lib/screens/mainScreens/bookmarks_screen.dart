import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:rocketdictionary/customWidgets/rocket_card.dart';
import 'package:rocketdictionary/customWidgets/scroll_glow_remover.dart';

class BookmarksScreen extends StatelessWidget {
  const BookmarksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box>(
        valueListenable: Hive.box('bookMarks').listenable(),
        builder: (context, box, widget) {
          if (box.length == 0) {
            return Center(
              child: Lottie.asset('assets/animation/bookmarksEmpty.json'),
            );
          } else {
            return ScrollGlowRemover(
              child: ListView.builder(
                  itemCount: box.length,
                  itemBuilder: (BuildContext context, int i) {
                    return RocketCard(
                      mainImageUrl: box.getAt(i).mainImageUrl,
                      rocketName: box.getAt(i).rocketName,
                      rocketManufacturerName:
                          box.getAt(i).rocketManufacturerName,
                      rocketStatus: box.getAt(i).rocketStatus,
                      countryImageUrl: box.getAt(i).countryImageUrl,
                      rocketType: box.getAt(i).rocketType,
                      rocketCPL: box.getAt(i).rocketCPL,
                      summary: box.getAt(i).summary,
                      content: box.getAt(i).content,
                      images: box.getAt(i).images,
                      id: box.getAt(i).id,
                      isBookmarked: true,
                    );
                  }),
            );
          }
        });
  }
}
