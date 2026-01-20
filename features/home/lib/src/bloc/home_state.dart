import 'package:core/core.dart';
import 'package:domain/domain.dart';

part 'home_state.freezed.dart';

@freezed
sealed class HomeState with _$HomeState {
  const factory HomeState.loading() = HomeLoading;

  const factory HomeState.success({
    required CollectionModel<TrackModel> trandingTracks,
  }) = HomeSuccess;

  const factory HomeState.failure({
    required String errorMessage,
  }) = HomeFailure;
}
