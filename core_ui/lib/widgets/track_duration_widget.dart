import 'package:flutter/material.dart';

class TrackDurationWidget extends StatelessWidget {
  const TrackDurationWidget({
    super.key,
    required this.currentDuration,
    required this.totalDuration,
    required this.onChanged,
  });

  final Duration totalDuration;
  final Duration currentDuration;
  final void Function(double)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SliderTheme(
          data: const SliderThemeData(
            padding: EdgeInsets.zero,
            thumbShape: HandleThumbShape(),
            thumbSize: WidgetStatePropertyAll<Size>(
              Size(4, 14),
            ),
          ),
          child: Slider(
            value: calculateProgress(currentDuration, totalDuration),
            onChanged: onChanged,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              _convertToString(currentDuration),
            ),
            Text(
              _convertToString(totalDuration),
            ),
          ],
        ),
      ],
    );
  }

  double calculateProgress(Duration current, Duration total) {
    return current.inMilliseconds / total.inMilliseconds;
  }

  String _convertToString(Duration dur) {
    final int minutes = dur.inMinutes;
    final int seconds = dur.inSeconds - minutes * Duration.secondsPerMinute;

    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }
}
