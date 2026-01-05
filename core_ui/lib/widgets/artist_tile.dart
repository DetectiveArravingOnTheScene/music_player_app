import 'package:flutter/material.dart';

import '../core_ui.dart';

class ArtistTile extends StatelessWidget {
  const ArtistTile({
    super.key,
    required this.artwork,
    required this.artistName,
    this.onPress,
  });

  final Image artwork;
  final String artistName;
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
              borderRadius: BorderRadius.circular(75),
              child: SizedBox(
                height: 150,
                width: 150,
                child: artwork,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              artistName,
              style: context.textTheme.titleMedium!.copyWith(fontSize: 18),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text('Artist', style: context.textTheme.titleMedium),
          ],
        ),
      ),
    );
  }
}
