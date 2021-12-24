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
  final ScrollController _scrollController = ScrollController();

  _scrollToTop() {
    _scrollController.animateTo(
      _scrollController.position.minScrollExtent,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          child: const Text('Soyuz'),
          onTap: () {
            _scrollToTop();
          },
        ),
        leading: CustomIconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ScrollGlowRemover(
        child: ListView(
          controller: _scrollController,
          children: [
            Container(
              color: Colors.black,
              height: 300,
              child: PageView(
                scrollDirection: Axis.horizontal,
                controller: _pageController,
                children: const [
                  Image(
                    image: AssetImage('assets/images/soyuz.jpg'),
                    fit: BoxFit.contain,
                    // fit: BoxFit.contain,
                  ),
                  Image(
                    image: AssetImage('assets/images/g1.jpg'),
                    fit: BoxFit.contain,
                    // fit: BoxFit.contain,
                  ),
                  Image(
                    image: AssetImage('assets/images/g2.jpg'),
                    fit: BoxFit.contain,
                    // fit: BoxFit.contain,
                  ),
                  Image(
                    image: AssetImage('assets/images/g3.jpg'),
                    fit: BoxFit.contain,
                    // fit: BoxFit.contain,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Center(child: Consumer(
                builder: (context, ref, child) {
                  return SmoothPageIndicator(
                    controller: _pageController,
                    count: 4,
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Last edited : 23h ago',
                    textAlign: TextAlign.right,
                    style: TextStyle(color: Colors.grey),
                  ),
                  Text(
                    'By Siddharth Bisht',
                    textAlign: TextAlign.right,
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            const CardDetailedHeadingParagraphs(
              isTopHeading: true,
              heading: 'History',
              body:
                  '''The first Soyuz flight was uncrewed and started on 28 November 1966. The first Soyuz mission with a crew, Soyuz 1, launched on 23 April 1967 but ended with a crash due to a parachute failure, killing cosmonaut Vladimir Komarov. The following flight was uncrewed. Soyuz 3, launched on 26 October 1968, became the program's first successful crewed mission. The only other flight to suffer a fatal accident, Soyuz 11, killed its crew of three when the cabin depressurized just before reentry. These are the only humans to date who are known to have died above the Kármán line.[1] Despite these early incidents, Soyuz is widely considered the world's safest, most cost-effective human spaceflight vehicle,[2] established by its unparalleled length of operational history.[3][4] Soyuz spacecraft were used to carry cosmonauts to and from Salyut and later Mir Soviet space stations, and are now used for transport to and from the International Space Station (ISS). At least one Soyuz spacecraft is docked to ISS at all times for use as an escape craft in the event of an emergency. The spacecraft is intended to be replaced by the six-person Orel spacecraft.[5]''',
            ),
            const CardDetailedHeadingParagraphs(
              isTopHeading: true,
              heading: 'Design',
              body:
                  '''A Soyuz spacecraft consists of three parts (from front to back):

A spheroid orbital module, which provides accommodation for the crew during their mission;
A small aerodynamic reentry module, which returns the crew to Earth;
A cylindrical service module with solar panels attached, which contains the instruments and engines.
The orbital and service modules are single-use and are destroyed upon reentry in the atmosphere. Though this might seem wasteful, it reduces the amount of heat shielding required for reentry, saving mass compared to designs containing all of the living space and life support in a single capsule. This allows smaller rockets to launch the spacecraft or can be used to increase the habitable space available to the crew (6.2 m3 (220 cu ft) in Apollo CM vs 7.5 m3 (260 cu ft) in Soyuz) in the mass budget. The orbital and reentry portions are habitable living space, with the service module containing the fuel, main engines and instrumentation. The Soyuz is not reusable; it is expendable. A new Soyuz spacecraft must be made for every mission.[6]

Soyuz can carry up to three crew members and provide life support for about 30 person days. The life support system provides a nitrogen/oxygen atmosphere at sea level partial pressures. The atmosphere is regenerated through potassium superoxide (KO2) cylinders, which absorb most of the carbon dioxide (CO2) and water produced by the crew and regenerates the oxygen, and lithium hydroxide (LiOH) cylinders which absorb leftover CO2.

The vehicle is protected during launch by a payload fairing, which is jettisoned along with the SAS at 2+1⁄2 minutes into launch. It has an automatic docking system. The ship can be operated automatically, or by a pilot independently of ground control.''',
            ),
          ],
        ),
      ),
    );
  }
}

class CardDetailedHeadingParagraphs extends StatelessWidget {
  const CardDetailedHeadingParagraphs(
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
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 10,
      ),
      child: Column(
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
          )
        ],
      ),
    );
  }
}
