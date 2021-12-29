import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:rocketdictionary/const.dart';
import 'package:rocketdictionary/providers.dart';

class DrawerSwitch extends ConsumerWidget {
  const DrawerSwitch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool switchValue = !ref.watch(lightModeActivatedStateProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.wb_sunny_outlined,
            color: Colors.orange,
            size: 34,
          ),
          const SizedBox(
            width: 7,
          ),
          Transform.scale(
            scale: 1.1,
            child: Switch(
              value: switchValue,
              onChanged: (val) {
                ref.read(lightModeActivatedStateProvider.state).state = !val;
              },
              activeColor: kCornFlowerBlue,
              inactiveThumbColor: Colors.orange,
            ),
          ),
          const SizedBox(
            width: 7,
          ),
          const Icon(
            Icons.nightlight_outlined,
            color: kCornFlowerBlue,
            size: 34,
          )
        ],
      ),
    );
  }
}
