import 'package:flutter/material.dart';
import 'package:rocketdictionary/customWidgets/rocket_card.dart';
import 'package:rocketdictionary/customWidgets/scroll_glow_remover.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScrollGlowRemover(
      child: ListView(
        children: const [
          RocketCard(
            mainImageUrl:
                'https://upload.wikimedia.org/wikipedia/commons/9/9a/Soyuz_TMA-9_launch.jpg',
            rocketName: 'Soyuz',
            rocketManufacturerName: 'Korolev Design Bureau',
            rocketStatus: 'Active',
            countryImageUrl:
                'https://cdn.britannica.com/42/3842-004-F47B77BC/Flag-Russia.jpg',
            rocketType: 'MLV',
            rocketCPL: '\$35 M',
          )
        ],
      ),
    );
  }
}
