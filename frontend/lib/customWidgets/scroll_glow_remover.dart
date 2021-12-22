import 'package:flutter/material.dart';

class ScrollGlowRemover extends StatelessWidget {
  const ScrollGlowRemover({Key? key, required this.child}) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (overscroll) {
        overscroll.disallowIndicator();
        return true;
      },
      child: child,
    );
  }
}
