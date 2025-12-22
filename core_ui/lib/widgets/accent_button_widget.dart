import 'package:flutter/material.dart';

class AccentButtonWidget extends StatelessWidget {
  const AccentButtonWidget({
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
    return FilledButton.icon(
      onPressed: onPressed,
      label: Text(label),
      icon: icon,
    );
  }
}
