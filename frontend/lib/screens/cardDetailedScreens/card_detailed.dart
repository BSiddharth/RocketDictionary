import 'package:flutter/material.dart';
import 'package:rocketdictionary/customWidgets/custom_icon_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rocketdictionary/screens/cardDetailedScreens/gallery_screen.dart';
import 'package:rocketdictionary/screens/cardDetailedScreens/wiki_screen.dart';

class CardDetailed extends StatelessWidget {
  final String rocketName;
  final String summary;
  final List images;
  final List content;
  const CardDetailed({
    Key? key,
    required this.content,
    required this.rocketName,
    required this.summary,
    required this.images,
  }) : super(key: key);
  static const name = '/CardDetailed';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(rocketName),
          leading: CustomIconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          bottom: const TabBar(
            tabs: [
              Tab(
                  icon: FaIcon(
                FontAwesomeIcons.wikipediaW,
                size: 16,
              )),
              Tab(
                  icon: FaIcon(
                FontAwesomeIcons.images,
                size: 16,
              )),
              // Tab(
              //     icon: Icon(
              //   Icons.chat_bubble_outline_rounded,
              //   size: 16,
              // )),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            WikiScreen(
              rocketName: rocketName,
              summary: summary,
              content: content,
              images: images,
            ),
            const GalleryScreen(),
            // const ChatPostScreen(),
          ],
        ),
      ),
    );
  }
}
