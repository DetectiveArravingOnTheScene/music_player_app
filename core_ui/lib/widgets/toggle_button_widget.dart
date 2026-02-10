import 'package:flutter/material.dart';

import '../core_ui.dart';

class ToggleButtonWidget extends StatelessWidget {
  const ToggleButtonWidget({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.value,
  });

  final void Function() onPressed;
  final Icon icon;
  final bool value;

  @override
  Widget build(BuildContext context) {
    return IconButton.filled(
      onPressed: onPressed,
      icon: icon,
      style: IconButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            10.0,
          ),
        ),
        backgroundColor: value ? null : context.colorScheme.surface,
        foregroundColor: value ? null : context.colorScheme.onSurface,
      ),
    );
  }
}
