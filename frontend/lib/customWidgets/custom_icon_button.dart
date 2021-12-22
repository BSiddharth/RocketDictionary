import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton(
      {Key? key, required this.onPressed, required this.icon})
      : super(key: key);

  final VoidCallback onPressed;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    IconThemeData iconThemeData = Theme.of(context).iconTheme;
    return IconButton(
      onPressed: onPressed,
      iconSize: iconThemeData.size!,
      icon: icon,
      color: iconThemeData.color,
    );
  }
}
