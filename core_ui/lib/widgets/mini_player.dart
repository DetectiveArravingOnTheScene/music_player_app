import 'package:flutter/material.dart';
import '../core_ui.dart';

class SwipeableMiniPlayer extends StatefulWidget {
  final Track currentTrack;
  final Track? nextTrack;
  final Track? prevTrack;
  final VoidCallback onSwipeNext;
  final VoidCallback onSwipePrev;

  const SwipeableMiniPlayer({
    super.key,
    required this.currentTrack,
    this.nextTrack,
    this.prevTrack,
    required this.onSwipeNext,
    required this.onSwipePrev,
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
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double width = constraints.maxWidth;
        final double totalShift = width + _cardGap;

        return GestureDetector(
          onHorizontalDragUpdate: _handleDragUpdate,
          onHorizontalDragEnd: (DragEndDetails details) =>
              _handleDragEnd(details, width),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              color: Colors.transparent,
              // Only this part rebuilds during drag
              child: ValueListenableBuilder<double>(
                valueListenable: _dragOffsetNotifier,
                builder: (BuildContext context, double offset, Widget? child) {
                  return Stack(
                    children: <Widget>[
                      if (widget.prevTrack != null)
                        Transform.translate(
                          offset: Offset(offset - totalShift, 0),
                          child: _MiniPlayerCard(track: widget.prevTrack),
                        ),
                      if (widget.nextTrack != null)
                        Transform.translate(
                          offset: Offset(offset + totalShift, 0),
                          child: _MiniPlayerCard(track: widget.nextTrack),
                        ),
                      Transform.translate(
                        offset: Offset(offset, 0),
                        child: _MiniPlayerCard(track: widget.currentTrack),
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
  }
}

class _MiniPlayerCard extends StatelessWidget {
  final Track track;

  const _MiniPlayerCard({required this.track});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: context.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: context.colorScheme.primary, width: 0.5),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Colors.black45,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                Container(
                  width: 64,
                  color: context.colorScheme.surface,
                  // Optimization: Use your extension
                  child: networkImageOrDefault(
                    track.coverUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        track.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: context.colorScheme.onPrimaryFixedVariant,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        track.author,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                          color: context.colorScheme.onPrimaryFixedVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.play_arrow_rounded,
                    color: context.colorScheme.onPrimaryFixedVariant,
                  ),
                  onPressed: () {},
                ),
                const SizedBox(width: 4),
              ],
            ),
          ),
          SizedBox(
            height: 2,
            child: LinearProgressIndicator(
              color: context.colorScheme.primary,
              value:
                  track.currentPosition.inSeconds /
                  (track.duration.inSeconds == 0
                      ? 1
                      : track.duration.inSeconds),
              backgroundColor: Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }
}
