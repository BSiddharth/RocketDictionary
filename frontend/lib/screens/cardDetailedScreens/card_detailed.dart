import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rocketdictionary/const.dart';
import 'package:rocketdictionary/customWidgets/custom_icon_button.dart';
import 'package:rocketdictionary/customWidgets/scroll_glow_remover.dart';
import 'package:rocketdictionary/providers.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CardDetailed extends StatelessWidget {
  final String rocketName;
  final String summary;
  final List images;
  final List content;
  CardDetailed({
    Key? key,
    required this.content,
    required this.rocketName,
    required this.summary,
    required this.images,
  }) : super(key: key);
  static const name = '/CardDetailed';
  final PageController _pageController = PageController(
    initialPage: 0,
  );
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
            onTap: () {
              _scrollController.animateTo(
                0.0,
                curve: Curves.easeOut,
                duration: const Duration(milliseconds: 300),
              );
            },
            child: Text(rocketName.trim())),
        leading: CustomIconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ScrollGlowRemover(
        child: ListView.builder(
            controller: _scrollController,
            itemCount: content.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      color: Colors.black,
                      height: 300,
                      child: PageView(
                        scrollDirection: Axis.horizontal,
                        controller: _pageController,
                        children: images
                            .map((ele) => CachedNetworkImage(imageUrl: ele))
                            .toList(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Center(child: Consumer(
                        builder: (context, ref, child) {
                          return SmoothPageIndicator(
                            controller: _pageController,
                            count: images.length,
                            effect: WormEffect(
                              spacing: 8.0,
                              radius: 16.0,
                              dotWidth: 8.0,
                              dotHeight: 8.0,
                              paintStyle: PaintingStyle.fill,
                              strokeWidth: 1.5,
                              dotColor:
                                  ref.watch(lightModeActivatedStateProvider)
                                      ? Colors.grey
                                      : Colors.white60,
                              activeDotColor:
                                  ref.watch(lightModeActivatedStateProvider)
                                      ? kPrussianBlue
                                      : Colors.white,
                            ),
                          );
                        },
                      )),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 10,
                      ),
                      child: Text(
                        summary.trim(),
                        style: const TextStyle(fontSize: 18, height: 1.5),
                      ),
                    ),
                  ],
                );
              }
              return CardDetailedHeadingParagraphs(content: content[index - 1]);
            }),
      ),
    );
  }
}

class CardDetailedHeadingParagraphs extends StatelessWidget {
  final List content;
  const CardDetailedHeadingParagraphs({Key? key, required this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> contentList = [];
    for (var i = 0; i < content.length; i++) {
      contentList.add(CardDetailedHeadingParagraphsHelper(
        heading: content[i]['title'].trim(),
        body: content[i]['content'].trim(),
        isTopHeading: i == 0,
      ));
    }
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 10,
      ),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: contentList),
    );
  }
}

class CardDetailedHeadingParagraphsHelper extends StatelessWidget {
  const CardDetailedHeadingParagraphsHelper(
      {Key? key,
      required this.heading,
      required this.body,
      this.isTopHeading = false})
      : super(key: key);
  final String heading;
  final String body;
  final bool isTopHeading;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(heading, style: TextStyle(fontSize: isTopHeading ? 30 : 25)),
        Container(
          color: Colors.grey,
          height: isTopHeading ? 1 : 0,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          body,
          style: const TextStyle(fontSize: 18, height: 1.5),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
