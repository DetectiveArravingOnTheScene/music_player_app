import 'package:flutter/material.dart';

class TrackDurationWidget extends StatefulWidget {
  const TrackDurationWidget({
    super.key,
    required this.positionStream,
    required this.currentDuration,
    required this.totalDuration,
    required this.onChanged,
  });

  final Stream<Duration> positionStream;
  final Duration currentDuration;
  final Duration totalDuration;
  final void Function(double)? onChanged;

  @override
  State<TrackDurationWidget> createState() => _TrackDurationWidgetState();
}

class _TrackDurationWidgetState extends State<TrackDurationWidget> {
  double _sliderValue = 0;
  bool _isDragging = false; // 1. Add this flag

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Duration>(
      stream: widget.positionStream,
      builder: (BuildContext context, AsyncSnapshot<Duration> asyncSnapshot) {
        if (!_isDragging) {
          _sliderValue = calculateProgress(
            asyncSnapshot.data ?? widget.currentDuration,
            widget.totalDuration,
          );
        }

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
                value: _sliderValue.clamp(
                  0.0,
                  1.0,
                ),
                onChangeStart: (_) {
                  setState(
                    () => _isDragging = true,
                  );
                },
                onChanged: (double d) {
                  setState(() => _sliderValue = d);
                },
                onChangeEnd: (double d) {
                  setState(
                    () => _isDragging = false,
                  );
                  widget.onChanged?.call(d);
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  _convertToString(
                    _isDragging
                        ? Duration(
                            milliseconds:
                                (widget.totalDuration.inMilliseconds *
                                        _sliderValue)
                                    .toInt(),
                          )
                        : (asyncSnapshot.data ?? widget.currentDuration),
                  ),
                ),
                Text(_convertToString(widget.totalDuration)),
              ],
            ),
          ],
        );
      },
    );
  }

  double calculateProgress(Duration current, Duration total) {
    if (total.inMilliseconds <= 0) return 0.0;
    return current.inMilliseconds / total.inMilliseconds;
  }

  String _convertToString(Duration dur) {
    final int minutes = dur.inMinutes;
    final int seconds = dur.inSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }
}
