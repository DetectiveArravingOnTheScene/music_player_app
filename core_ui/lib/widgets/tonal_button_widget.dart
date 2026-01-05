import 'package:flutter/material.dart';

class TonalButtonWidget extends StatelessWidget {
  const TonalButtonWidget({
    super.key,
    required this.onPressed,
    required this.label,
    this.icon,
  });

  final void Function() onPressed;
  final String label;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return FilledButton.tonalIcon(
      onPressed: onPressed,
      label: Text(label),
      icon: icon,
    );
  }
}
