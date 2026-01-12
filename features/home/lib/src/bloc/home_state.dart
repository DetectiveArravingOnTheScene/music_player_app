import 'package:core/core.dart';
import 'package:domain/domain.dart';

part 'home_state.freezed.dart';

@freezed
abstract class HomeState with _$HomeState {
  const factory HomeState.loading() = _Loading;

  const factory HomeState.success({
    required CollectionModel<TrackModel> trandingTracks,
  }) = _Success;

  const factory HomeState.failure({
    required String errorMessage,
  }) = _Failure;
}
