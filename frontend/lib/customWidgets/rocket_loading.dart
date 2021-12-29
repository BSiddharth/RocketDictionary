import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class RocketLoading extends StatelessWidget {
  const RocketLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      'assets/animation/rocketLoading.json',
      width: 400,
      height: 400,
      fit: BoxFit.fill,
    );
  }
}
