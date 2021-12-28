import 'package:flutter/material.dart';
import 'package:rocketdictionary/customWidgets/custom_icon_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rocketdictionary/screens/cardDetailedScreens/chat_post_screen.dart';
import 'package:rocketdictionary/screens/cardDetailedScreens/gallery_screen.dart';
import 'package:rocketdictionary/screens/cardDetailedScreens/wiki_screen.dart';

class CardDetailed extends StatelessWidget {
  const CardDetailed({Key? key}) : super(key: key);
  static const name = '/CardDetailed';

  // final ScrollController _scrollController = ScrollController();

  // _scrollToTop() {
  //   _scrollController.animateTo(
  //     _scrollController.position.minScrollExtent,
  //     curve: Curves.easeOut,
  //     duration: const Duration(milliseconds: 500),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: GestureDetector(
            child: const Text('Soyuz'),
            onTap: () {
              // _scrollToTop();
            },
          ),
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
              Tab(
                  icon: Icon(
                Icons.chat_bubble_outline_rounded,
                size: 16,
              )),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            WikiScreen(),
            const GalleryScreen(),
            const ChatPostScreen(),
          ],
        ),
      ),
    );
  }
}
