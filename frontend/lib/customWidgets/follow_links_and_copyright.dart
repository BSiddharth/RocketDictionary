import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:rocketdictionary/const.dart';
import 'package:rocketdictionary/providers.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FollowLinksAndCopyRight extends ConsumerWidget {
  const FollowLinksAndCopyRight({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Color textColor = ref.watch(lightModeActivatedStateProvider)
        ? Colors.grey
        : kAntiFlashWhite;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        children: [
          Text(
            'Follow us on',
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              FaIcon(FontAwesomeIcons.facebookF),
              FaIcon(FontAwesomeIcons.twitter),
              FaIcon(FontAwesomeIcons.instagram),
              FaIcon(FontAwesomeIcons.linkedinIn),
              FaIcon(FontAwesomeIcons.telegram),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            'Ⓒ 2021 RocketDictionary® v1.0.0',
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
