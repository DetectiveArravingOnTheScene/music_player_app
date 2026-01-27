import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import '../core_ui.dart';

class MiniPlayerCard extends StatelessWidget {
  final TrackModel track;
  final Duration? position;
  final VoidCallback onPauseToggle;
  final VoidCallback onLikeToggle;
  final bool isLiked;
  final bool isPaused;

  const MiniPlayerCard({
    required this.track,
    required this.position,
    required this.onPauseToggle,
    required this.onLikeToggle,
    required this.isLiked,
    required this.isPaused,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: context.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(8),
        border: Border(
          left: BorderSide(color: context.colorScheme.primary, width: 0.5),
          right: BorderSide(color: context.colorScheme.primary, width: 0.5),
          top: BorderSide(color: context.colorScheme.primary, width: 0.5),
        ),
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
                // Cover
                Container(
                  width: 64,
                  color: context.colorScheme.surface,
                  child: networkImageOrDefault(track.artworkUrl),
                ),
                const SizedBox(width: 12),
                // Info
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
                        track.artist.username,
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
                    isLiked ? Icons.favorite : Icons.favorite_border,
                  ),
                  onPressed: onLikeToggle,
                ),
                IconButton(
                  icon: Icon(
                    isPaused ? Icons.play_arrow_rounded : Icons.pause,
                    color: context.colorScheme.onPrimaryFixedVariant,
                  ),
                  onPressed: onPauseToggle,
                ),
                const SizedBox(width: 4),
              ],
            ),
          ),
          // Duration Line
          SizedBox(
            height: 2,
            child: LinearProgressIndicator(
              color: context.colorScheme.primary,
              value: position == null
                  ? 0
                  : position!.inSeconds / (track.duration / 1000),
              backgroundColor: Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }
}
