import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

import '../../player.dart';

@RoutePage()
class PlayerScreen extends StatelessWidget {
  const PlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayerBloc, PlayerBlocState>(
      builder: (BuildContext context, PlayerBlocState state) {
        return Scaffold(
          appBar: AppBar(),
          body: SafeArea(
            child: state.currentTrack == null
                ? const LoadingWidget()
                : Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          width: double.infinity,
                          child: networkImageOrDefault(
                            state.currentTrack!.artworkUrl,
                            fit: BoxFit.fill,
                            highQuality: true,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: .spaceBetween,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: .start,
                              children: <Widget>[
                                Text(
                                  state.currentTrack!.title,
                                  style: context.textTheme.titleLarge!.copyWith(
                                    fontWeight: .w500,
                                  ),
                                ),
                                Text(
                                  state.currentTrack!.artist.username,
                                  style: context.textTheme.titleMedium!
                                      .copyWith(fontWeight: .w500),
                                ),
                              ],
                            ),
                            IconButton(
                              onPressed: () {
                                context.read<PlayerBloc>().add(
                                  PlayerLikeTrack(
                                    track: state.currentTrack!,
                                    liked: !state.currentTrack!.isLiked,
                                  ),
                                );
                              },
                              icon: Icon(
                                state.currentTrack!.isLiked
                                    ? Icons.favorite
                                    : Icons.favorite_outline_rounded,
                              ),
                            ),
                          ],
                        ),
                        TrackDurationWidget(
                          positionStream: context
                              .read<PlayerBloc>()
                              .positionStream,
                          currentDuration: context
                              .read<PlayerBloc>()
                              .lastPosition,
                          totalDuration: Duration(
                            milliseconds: state.currentTrack!.duration,
                          ),
                          onChanged: (double value) {
                            context.read<PlayerBloc>().add(
                              PlayerSeek(
                                Duration(
                                  milliseconds:
                                      (value * state.currentTrack!.duration)
                                          .toInt(),
                                ),
                              ),
                            );
                          },
                        ),
                        Row(
                          mainAxisAlignment: .spaceEvenly,
                          children: <Widget>[
                            ToggleButtonWidget(
                              onPressed: () {
                                context.read<PlayerBloc>().add(
                                  PlayerToggleShuffle(),
                                );
                              },
                              icon: const Icon(Icons.shuffle),
                              value: state.isShuffleMode,
                            ),
                            IconButtonWidget(
                              onPressed: () {
                                context.read<PlayerBloc>().add(
                                  PlayerPrevious(),
                                );
                              },
                              icon: const Icon(Icons.skip_previous),
                              size: 32,
                            ),
                            IconButtonWidget(
                              onPressed: () {
                                if (state.isPlaying) {
                                  context.read<PlayerBloc>().add(PlayerPause());
                                } else {
                                  context.read<PlayerBloc>().add(
                                    PlayerResume(),
                                  );
                                }
                              },
                              icon: Icon(
                                state.isPlaying
                                    ? Icons.pause
                                    : Icons.play_arrow,
                              ),
                              filled: true,
                              size: 48,
                            ),
                            IconButtonWidget(
                              onPressed: () {
                                context.read<PlayerBloc>().add(PlayerNext());
                              },
                              icon: const Icon(Icons.skip_next),
                              size: 32,
                            ),
                            ToggleButtonWidget(
                              onPressed: () {
                                context.read<PlayerBloc>().add(
                                  PlayerToggleLoop(),
                                );
                              },
                              icon: Icon(
                                state.loopMode == .one
                                    ? Icons.repeat_one
                                    : Icons.repeat,
                              ),
                              value: state.isLoop,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
          ),
        );
      },
    );
  }
}
