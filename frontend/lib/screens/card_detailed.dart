import 'package:flutter/material.dart';
import 'package:rocketdictionary/customWidgets/custom_icon_button.dart';

class CardDetailed extends StatelessWidget {
  const CardDetailed({Key? key}) : super(key: key);
  static const name = '/CardDetailed';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CustomIconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
