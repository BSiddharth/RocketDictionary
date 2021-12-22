import 'package:flutter/material.dart';
import 'package:rocketdictionary/const.dart';
import 'package:rocketdictionary/customWidgets/custom_icon_button.dart';
import 'package:rocketdictionary/customWidgets/scroll_glow_remover.dart';
import 'package:rocketdictionary/providers.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CardDetailed extends StatelessWidget {
  CardDetailed({Key? key}) : super(key: key);
  static const name = '/CardDetailed';
  final PageController _pageController = PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Soyuz'),
        leading: CustomIconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        children: [
          Container(
            color: Colors.black,
            height: 300,
            child: ScrollGlowRemover(
              child: PageView(
                scrollDirection: Axis.horizontal,
                controller: _pageController,
                children: const [
                  Image(
                    image: AssetImage('assets/images/g1.jpg'),
                    // fit: BoxFit.contain,
                  ),
                  Image(
                    image: AssetImage('assets/images/g2.jpg'),
                    // fit: BoxFit.contain,
                  ),
                  Image(
                    image: AssetImage('assets/images/g3.jpg'),
                    // fit: BoxFit.contain,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: Consumer(
              builder: (context, ref, child) {
                return SmoothPageIndicator(
                  controller: _pageController,
                  count: 3,
                  effect: WormEffect(
                    spacing: 8.0,
                    radius: 16.0,
                    dotWidth: 8.0,
                    dotHeight: 8.0,
                    paintStyle: PaintingStyle.fill,
                    strokeWidth: 1.5,
                    dotColor: ref.watch(lightModeActivatedStateProvider)
                        ? Colors.grey
                        : Colors.white60,
                    activeDotColor: ref.watch(lightModeActivatedStateProvider)
                        ? kPrussianBlue
                        : Colors.white,
                  ),
                );
              },
            )),
          ),
        ],
      ),
    );
  }
}
