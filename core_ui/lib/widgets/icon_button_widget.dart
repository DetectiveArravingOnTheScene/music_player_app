import 'package:flutter/material.dart';

class IconButtonWidget extends StatelessWidget {
  const IconButtonWidget({
    super.key,
    required this.onPressed,
    required this.icon,
    this.filled = false,
    this.size,
  });

  final void Function() onPressed;
  final Widget icon;
  final bool filled;
  final double? size;

  @override
  Widget build(BuildContext context) {
    if (filled) {
      return IconButton.filled(
        onPressed: onPressed,
        icon: icon,
        iconSize: size,
      );
    } else {
      return IconButton.outlined(
        onPressed: onPressed,
        icon: icon,
        iconSize: size,
      );
    }
  }
}
