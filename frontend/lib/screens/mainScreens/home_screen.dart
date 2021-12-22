import 'package:flutter/material.dart';
import 'package:rocketdictionary/const.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rocketdictionary/customWidgets/scroll_glow_remover.dart';
import 'package:rocketdictionary/providers.dart';
import 'package:rocketdictionary/screens/card_detailed.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScrollGlowRemover(
      child: ListView(
        children: const [
          RocketCard(),
        ],
      ),
    );
  }
}

class RocketCard extends StatelessWidget {
  const RocketCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, CardDetailed.name);
      },
      child: Consumer(
        builder: (context, ref, child) {
          final isLightTheme = ref.watch(lightModeActivatedStateProvider);
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            child: Container(
              decoration: isLightTheme
                  ? const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    )
                  : null,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 300,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/soyuz.jpg'),
                          fit: BoxFit.cover,
                        ),
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          bottomLeft: Radius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: 300,
                      decoration: BoxDecoration(
                        color: isLightTheme
                            ? Colors.white
                            : kDarkModeSupportBlackishGrey,
                        // color: kDarkModeSupportBlackishGrey,
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        ),
                      ),
                      child: const RocketCardInfo(),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class RocketCardInfo extends StatelessWidget {
  const RocketCardInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            RocketCardInfoBlock(title: 'Name', body: 'Soyuz'),
            RocketCardInfoBlock(
              title: 'Country of origin',
              body: 'Soviet Union',
              isImage: true,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            RocketCardInfoBlock(
                title: 'Manufacturer', body: 'Korolev Design Bureau'),
            RocketCardInfoBlock(title: 'Type', body: 'MLV'),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            RocketCardInfoBlock(title: 'Status', body: 'In service'),
            RocketCardInfoBlock(title: 'Cost per Launch', body: '\$35 M'),
          ],
        ),
      ],
    );
  }
}

class RocketCardInfoBlock extends StatelessWidget {
  final String body;
  final String title;
  final bool isImage;
  const RocketCardInfoBlock(
      {Key? key, required this.title, required this.body, this.isImage = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        isImage
            ? const CircleAvatar(
                radius: 18,
                backgroundImage: AssetImage('assets/images/russiaFlag.png'),
              )
            : Text(
                body,
                // style: const TextStyle(color: Colors.black),
                // style: const TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
        Text(
          title,
          style:
              const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
