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

  double _dragOffset = 0.0;

  final double _threshold = 100.0; // Distance to commit swipe
  final double _resistanceFactor = 0.15; // Resistance at ends
  final double _cardGap = 16.0; // Visual gap between cards during swipe

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    if (_controller.isAnimating) return;

    final double delta = details.primaryDelta!;

    // Check limits
    final bool isMovingLeft = _dragOffset + delta < 0;
    final bool isMovingRight = _dragOffset + delta > 0;
    final bool nextExists = widget.nextTrack != null;
    final bool prevExists = widget.prevTrack != null;

    // Apply Resistance if hitting a wall (null track)
    if ((isMovingLeft && !nextExists) || (isMovingRight && !prevExists)) {
      _dragOffset += delta * _resistanceFactor;
    } else {
      _dragOffset += delta;
    }

    setState(() {});
  }

  void _handleDragEnd(DragEndDetails details, double width) {
    if (_controller.isAnimating) return;
    if (_dragOffset < -_threshold && widget.nextTrack != null) {
      // Swiped Left -> Go to Next
      _animateToPosition(-width - _cardGap, () => widget.onSwipeNext());
    } else if (_dragOffset > _threshold && widget.prevTrack != null) {
      // Swiped Right -> Go to Prev
      _animateToPosition(width + _cardGap, () => widget.onSwipePrev());
    } else {
      // Cancel -> Snap back to 0
      _animateToPosition(0.0, null);
    }
  }

  void _animateToPosition(double targetOffset, VoidCallback? onComplete) {
    final double start = _dragOffset;

    final Animation<double> animation = Tween<double>(
      begin: start,
      end: targetOffset,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    void listener() {
      setState(() {
        _dragOffset = animation.value;
      });
    }

    animation.addListener(listener);

    _controller.reset();
    _controller.forward().then((_) {
      animation.removeListener(listener);

      if (onComplete != null) {
        // 1. Trigger the data update (Parent changes Current Track)
        onComplete();
        _dragOffset = 0.0;
        setState(() {});
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
                  child: Stack(
                    children: <Widget>[
                      if (widget.prevTrack != null)
                        Transform.translate(
                          offset: Offset(_dragOffset - totalShift, 0),
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
                          offset: Offset(_dragOffset + totalShift, 0),
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
                        offset: Offset(_dragOffset, 0),
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
