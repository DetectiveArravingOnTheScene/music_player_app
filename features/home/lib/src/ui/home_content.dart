import 'package:core/core.dart';
import 'package:core_ui/extensions/network_image_or_default.dart';
import 'package:core_ui/widgets/error_retry_widget.dart';
import 'package:core_ui/widgets/loading_widget.dart';
import 'package:core_ui/widgets/track_tile.dart';
import 'package:core_ui/widgets/vertical_list.dart';
import 'package:domain/models/music_models/collection_model.dart';
import 'package:domain/models/music_models/track_model.dart';
import 'package:flutter/material.dart';
import 'package:player/player.dart';

import '../bloc/home_bloc.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (BuildContext context, HomeState state) {
        return state.when(
          loading: () {
            return const LoadingWidget();
          },
          success: (CollectionModel<TrackModel> trandingTracks) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: VerticalList(
                  label: t.home.trendingTracks,
                  itemBuilder: (BuildContext context, int index) {
                    return TrackTile(
                      trackImage: networkImageOrDefault(
                        trandingTracks.items[index].artworkUrl,
                      ),
                      trackName: trandingTracks.items[index].title,
                      artistName: trandingTracks.items[index].artist.username,
                      onLikePressed: () {
                        context.read<HomeBloc>().add(
                          HomeLikeTrack(
                            track: trandingTracks.items[index],
                            liked: !trandingTracks.items[index].isLiked,
                          ),
                        );
                      },
                      onMorePressed: () {},
                      isLiked: trandingTracks.items[index].isLiked,
                      onPress: () {
                        context.read<PlayerBloc>().add(
                          PlayerSetPlaylist(playlist: trandingTracks.items),
                        );
                      },
                    );
                  },
                  itemCount: trandingTracks.items.length,
                ),
              ),
            );
          },
          failure: (String errorMessage) {
            return ErrorRetryWidget(
              errorMessage: errorMessage,
              onRetryPressed: () {
                context.read<HomeBloc>().add(const HomePageOpenedEvent());
              },
            );
          },
        );
      },
    );
  }
}
