import 'package:flutter/material.dart';

import '../core_ui.dart';

class TrackTile extends StatelessWidget {
  const TrackTile({
    super.key,
    required this.trackImage,
    required this.trackName,
    required this.artistName,
    required this.onLikePressed,
    required this.onMorePressed,
    required this.isLiked,
    required this.onPress,
  });

  final Image trackImage;
  final String trackName;
  final String artistName;
  final bool isLiked;
  final void Function() onPress;
  final void Function() onLikePressed;
  final void Function() onMorePressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              width: 250,
              child: Row(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4.0),
                    child: SizedBox(
                      width: 50,
                      height: 50,
                      child: trackImage,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          trackName,
                          style: context.textTheme.titleMedium,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        Text(artistName, style: context.textTheme.bodyMedium),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: <Widget>[
                IconButton(
                  onPressed: onLikePressed,
                  icon: Icon(
                    isLiked ? Icons.favorite : Icons.favorite_border_outlined,
                  ),
                ),
                IconButton(
                  onPressed: onMorePressed,
                  icon: const Icon(Icons.more_vert),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
