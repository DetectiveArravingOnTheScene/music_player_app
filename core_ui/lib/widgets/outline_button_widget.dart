import 'package:flutter/material.dart';

class OutlineButtonWidget extends StatelessWidget {
  const OutlineButtonWidget({
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
    return OutlinedButton.icon(
      onPressed: onPressed,
      label: Text(label),
      icon: icon,
    );
  }
}
