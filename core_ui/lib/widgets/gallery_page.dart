import 'package:flutter/material.dart';

import 'accent_button_widget.dart';
import 'artist_tile.dart';
import 'horizontal_list.dart';
import 'mini_player.dart';
import 'outline_button_widget.dart';
import 'playlist_tile.dart';
import 'tonal_button_widget.dart';
import 'track_duration_widget.dart';
import 'track_tile.dart';
import 'vertical_list.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({super.key});

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class Track {
  final String title;
  final String author;
  final String coverUrl;
  final Duration duration;
  final Duration currentPosition;

  Track({
    required this.title,
    required this.author,
    required this.coverUrl,
    required this.duration,
    required this.currentPosition,
  });
}

class _GalleryPageState extends State<GalleryPage> {
  Duration currentDuration = const Duration(seconds: 90);

  final List<Track> _allTracks = List<Track>.generate(
    5,
    (int index) => Track(
      title: 'Track Number ${index + 1}',
      author: 'Artist ${index + 1}',
      coverUrl: 'https://picsum.photos/100?random=$index',
      duration: const Duration(minutes: 3),
      currentPosition: Duration(seconds: 30 + (index * 10)),
    ),
  );

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            spacing: 16,
            children: <Widget>[
              _showTrackDurationWidget(),
              _showButtons(),
              _showPlaylists(),
              _showArtists(),
              _showTracks(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _showTrackDurationWidget() {
    const Duration totalDuration = Duration(seconds: 305);
    return TrackDurationWidget(
      currentDuration: currentDuration,
      totalDuration: totalDuration,
      onChanged: (double c) {
        setState(() {
          currentDuration = Duration(
            milliseconds: (c * totalDuration.inMilliseconds).round(),
          );
        });
      },
    );
  }

  Widget _showButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        AccentButtonWidget(
          label: 'Accent',
          onPressed: () {},
          icon: const Icon(Icons.play_arrow),
        ),
        OutlineButtonWidget(
          label: 'Outline',
          onPressed: () {},
          icon: const Icon(Icons.play_arrow),
        ),
        TonalButtonWidget(
          label: 'Tonal',
          onPressed: () {},
          icon: const Icon(Icons.play_arrow),
        ),
      ],
    );
  }

  Widget _showPlaylists() {
    return HorizontalList(
      label: 'Playlists',
      itemCount: 3,
      itemBuilder: (BuildContext context, int index) {
        return PlaylistTile(
          playlistName: 'Threat to Survival',
          trackCount: 12,
          artwork: Image.asset('assets/song_cover.jpg'),
          creatorName: 'Shinedown',
        );
      },
    );
  }

  Widget _showArtists() {
    return HorizontalList(
      label: 'Artists',
      itemCount: 3,
      itemBuilder: (BuildContext context, int index) {
        return ArtistTile(
          artistName: 'Shinedown',
          artwork: Image.asset(
            'assets/artist_cover.png',
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }

  Widget _showTracks() {
    return VerticalList(
      label: 'Tracks',
      itemBuilder: (BuildContext context, int index) {
        return TrackTile(
          trackImage: Image.asset('assets/song_cover.jpg'),
          trackName: 'How did you love',
          artistName: 'Shinedown',
          isLiked: index == 3 ? true : false,
          onPress: () {},
          onLikePressed: () {},
          onMorePressed: () {},
        );
      },
      itemCount: 5,
    );
  }
}
