import 'package:core/core.dart';
import 'package:flutter/material.dart';

import 'tonal_button_widget.dart';

class ErrorRetryWidget extends StatelessWidget {
  const ErrorRetryWidget({
    required this.errorMessage,
    required this.onRetryPressed,
    super.key,
  });

  final void Function() onRetryPressed;
  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        spacing: 8,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Icon(
            Icons.error_sharp,
            size: 64,
          ),
          Text(errorMessage),

          TonalButtonWidget(onPressed: onRetryPressed, label: t.retry),
        ],
      ),
    );
  }
}
