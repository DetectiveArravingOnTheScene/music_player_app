import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

import 'mini_player_card.dart';

class SwipeableMiniPlayer extends StatefulWidget {
  final Stream<Duration> positionStream;
  final TrackModel currentTrack;
  final bool isPaused;
  final TrackModel? nextTrack;
  final TrackModel? prevTrack;
  final VoidCallback onSwipeNext;
  final VoidCallback onSwipePrev;
  final VoidCallback onTap;
  final VoidCallback onPauseToggle;
  final VoidCallback onLikeToggle;

  const SwipeableMiniPlayer({
    super.key,
    required this.currentTrack,
    required this.isPaused,
    required this.positionStream,
    required this.onSwipeNext,
    required this.onSwipePrev,
    required this.onTap,
    required this.onPauseToggle,
    required this.onLikeToggle,
    this.nextTrack,
    this.prevTrack,
  });

  @override
  State<SwipeableMiniPlayer> createState() => _SwipeableMiniPlayerState();
}

class _SwipeableMiniPlayerState extends State<SwipeableMiniPlayer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late ValueNotifier<double> _dragOffsetNotifier;

  final double _threshold = 100.0;
  final double _resistanceFactor = 0.15;
  final double _cardGap = 16.0;

  @override
  void initState() {
    super.initState();
    _dragOffsetNotifier = ValueNotifier<double>(0.0);
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _dragOffsetNotifier.dispose();
    super.dispose();
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    if (_controller.isAnimating) return;

    final double delta = details.primaryDelta!;
    double currentOffset = _dragOffsetNotifier.value;

    final bool isMovingLeft = currentOffset + delta < 0;
    final bool isMovingRight = currentOffset + delta > 0;
    final bool nextExists = widget.nextTrack != null;
    final bool prevExists = widget.prevTrack != null;

    if ((isMovingLeft && !nextExists) || (isMovingRight && !prevExists)) {
      currentOffset += delta * _resistanceFactor;
    } else {
      currentOffset += delta;
    }

    // Direct update without setState
    _dragOffsetNotifier.value = currentOffset;
  }

  void _handleDragEnd(DragEndDetails details, double width) {
    if (_controller.isAnimating) return;

    final double currentOffset = _dragOffsetNotifier.value;

    if (currentOffset < -_threshold && widget.nextTrack != null) {
      _animateToPosition(-width - _cardGap, widget.onSwipeNext);
    } else if (currentOffset > _threshold && widget.prevTrack != null) {
      _animateToPosition(width + _cardGap, widget.onSwipePrev);
    } else {
      _animateToPosition(0.0, null);
    }
  }

  void _animateToPosition(double targetOffset, VoidCallback? onComplete) {
    final double start = _dragOffsetNotifier.value;

    final Animation<double> animation = Tween<double>(
      begin: start,
      end: targetOffset,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    // Listen to animation frame and update notifier
    void listener() {
      _dragOffsetNotifier.value = animation.value;
    }

    animation.addListener(listener);

    _controller.reset();
    _controller.forward().then((_) {
      animation.removeListener(listener);

      if (onComplete != null) {
        onComplete();
        // Reset offset silently after parent update
        _dragOffsetNotifier.value = 0.0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Duration>(
      stream: widget.positionStream,
      builder: (BuildContext context, AsyncSnapshot<Duration> asyncSnapshot) {
        return LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final double width = constraints.maxWidth;
            final double totalShift = width + _cardGap;

            return GestureDetector(
              onTap: widget.onTap,
              onHorizontalDragUpdate: _handleDragUpdate,
              onHorizontalDragEnd: (DragEndDetails details) =>
                  _handleDragEnd(details, width),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  color: Colors.transparent, // Capture taps
                  child: ValueListenableBuilder<double>(
                    valueListenable: _dragOffsetNotifier,
                    builder:
                        (BuildContext context, double offset, Widget? child) {
                          return Stack(
                            children: <Widget>[
                              if (widget.prevTrack != null)
                                Transform.translate(
                                  offset: Offset(offset - totalShift, 0),
                                  child: MiniPlayerCard(
                                    onLikeToggle: widget.onLikeToggle,
                                    onPauseToggle: widget.onPauseToggle,
                                    track: widget.prevTrack!,
                                    position: asyncSnapshot.data,
                                    isLiked: widget.currentTrack.isLiked,
                                    isPaused: widget.isPaused,
                                  ),
                                ),

                              if (widget.nextTrack != null)
                                Transform.translate(
                                  offset: Offset(offset + totalShift, 0),
                                  child: MiniPlayerCard(
                                    onLikeToggle: widget.onLikeToggle,
                                    onPauseToggle: widget.onPauseToggle,
                                    track: widget.nextTrack!,
                                    position: asyncSnapshot.data,
                                    isLiked: widget.currentTrack.isLiked,
                                    isPaused: widget.isPaused,
                                  ),
                                ),

                              Transform.translate(
                                offset: Offset(offset, 0),
                                child: MiniPlayerCard(
                                  onLikeToggle: widget.onLikeToggle,
                                  onPauseToggle: widget.onPauseToggle,
                                  track: widget.currentTrack,
                                  position: asyncSnapshot.data,
                                  isLiked: widget.currentTrack.isLiked,
                                  isPaused: widget.isPaused,
                                ),
                              ),
                            ],
                          );
                        },
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
