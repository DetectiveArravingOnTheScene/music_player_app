import 'package:flutter/material.dart';

import '../core_ui.dart';

class PlaylistTile extends StatelessWidget {
  const PlaylistTile({
    super.key,
    required this.artwork,
    required this.playlistName,
    required this.trackCount,
    required this.creatorName,
    this.onPress,
  });

  final Image artwork;
  final String playlistName;
  final int trackCount;
  final String creatorName;
  final VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: SizedBox(
        width: 150,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: SizedBox(
                height: 150,
                width: 150,
                child: artwork,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              playlistName,
              style: context.textTheme.titleMedium!.copyWith(fontSize: 18),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(creatorName, style: context.textTheme.titleMedium),
            Text('$trackCount tracks'),
          ],
        ),
      ),
    );
  }
}
