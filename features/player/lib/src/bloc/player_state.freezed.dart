// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'player_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PlayerBlocState {

 List<TrackModel> get playlist; int get currentIndex; bool get isShuffleMode; LoopMode get loopMode; List<int> get shuffleIndices; bool get isPlaying; bool get isLoading; bool get isError; String get errorMessage;
/// Create a copy of PlayerBlocState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlayerBlocStateCopyWith<PlayerBlocState> get copyWith => _$PlayerBlocStateCopyWithImpl<PlayerBlocState>(this as PlayerBlocState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlayerBlocState&&const DeepCollectionEquality().equals(other.playlist, playlist)&&(identical(other.currentIndex, currentIndex) || other.currentIndex == currentIndex)&&(identical(other.isShuffleMode, isShuffleMode) || other.isShuffleMode == isShuffleMode)&&(identical(other.loopMode, loopMode) || other.loopMode == loopMode)&&const DeepCollectionEquality().equals(other.shuffleIndices, shuffleIndices)&&(identical(other.isPlaying, isPlaying) || other.isPlaying == isPlaying)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isError, isError) || other.isError == isError)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(playlist),currentIndex,isShuffleMode,loopMode,const DeepCollectionEquality().hash(shuffleIndices),isPlaying,isLoading,isError,errorMessage);

@override
String toString() {
  return 'PlayerBlocState(playlist: $playlist, currentIndex: $currentIndex, isShuffleMode: $isShuffleMode, loopMode: $loopMode, shuffleIndices: $shuffleIndices, isPlaying: $isPlaying, isLoading: $isLoading, isError: $isError, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $PlayerBlocStateCopyWith<$Res>  {
  factory $PlayerBlocStateCopyWith(PlayerBlocState value, $Res Function(PlayerBlocState) _then) = _$PlayerBlocStateCopyWithImpl;
@useResult
$Res call({
 List<TrackModel> playlist, int currentIndex, bool isShuffleMode, LoopMode loopMode, List<int> shuffleIndices, bool isPlaying, bool isLoading, bool isError, String errorMessage
});




}
/// @nodoc
class _$PlayerBlocStateCopyWithImpl<$Res>
    implements $PlayerBlocStateCopyWith<$Res> {
  _$PlayerBlocStateCopyWithImpl(this._self, this._then);

  final PlayerBlocState _self;
  final $Res Function(PlayerBlocState) _then;

/// Create a copy of PlayerBlocState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? playlist = null,Object? currentIndex = null,Object? isShuffleMode = null,Object? loopMode = null,Object? shuffleIndices = null,Object? isPlaying = null,Object? isLoading = null,Object? isError = null,Object? errorMessage = null,}) {
  return _then(_self.copyWith(
playlist: null == playlist ? _self.playlist : playlist // ignore: cast_nullable_to_non_nullable
as List<TrackModel>,currentIndex: null == currentIndex ? _self.currentIndex : currentIndex // ignore: cast_nullable_to_non_nullable
as int,isShuffleMode: null == isShuffleMode ? _self.isShuffleMode : isShuffleMode // ignore: cast_nullable_to_non_nullable
as bool,loopMode: null == loopMode ? _self.loopMode : loopMode // ignore: cast_nullable_to_non_nullable
as LoopMode,shuffleIndices: null == shuffleIndices ? _self.shuffleIndices : shuffleIndices // ignore: cast_nullable_to_non_nullable
as List<int>,isPlaying: null == isPlaying ? _self.isPlaying : isPlaying // ignore: cast_nullable_to_non_nullable
as bool,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isError: null == isError ? _self.isError : isError // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: null == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PlayerBlocState].
extension PlayerBlocStatePatterns on PlayerBlocState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlayerBlocState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlayerBlocState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlayerBlocState value)  $default,){
final _that = this;
switch (_that) {
case _PlayerBlocState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlayerBlocState value)?  $default,){
final _that = this;
switch (_that) {
case _PlayerBlocState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<TrackModel> playlist,  int currentIndex,  bool isShuffleMode,  LoopMode loopMode,  List<int> shuffleIndices,  bool isPlaying,  bool isLoading,  bool isError,  String errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlayerBlocState() when $default != null:
return $default(_that.playlist,_that.currentIndex,_that.isShuffleMode,_that.loopMode,_that.shuffleIndices,_that.isPlaying,_that.isLoading,_that.isError,_that.errorMessage);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<TrackModel> playlist,  int currentIndex,  bool isShuffleMode,  LoopMode loopMode,  List<int> shuffleIndices,  bool isPlaying,  bool isLoading,  bool isError,  String errorMessage)  $default,) {final _that = this;
switch (_that) {
case _PlayerBlocState():
return $default(_that.playlist,_that.currentIndex,_that.isShuffleMode,_that.loopMode,_that.shuffleIndices,_that.isPlaying,_that.isLoading,_that.isError,_that.errorMessage);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<TrackModel> playlist,  int currentIndex,  bool isShuffleMode,  LoopMode loopMode,  List<int> shuffleIndices,  bool isPlaying,  bool isLoading,  bool isError,  String errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _PlayerBlocState() when $default != null:
return $default(_that.playlist,_that.currentIndex,_that.isShuffleMode,_that.loopMode,_that.shuffleIndices,_that.isPlaying,_that.isLoading,_that.isError,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _PlayerBlocState extends PlayerBlocState {
  const _PlayerBlocState({final  List<TrackModel> playlist = const <TrackModel>[], this.currentIndex = 0, this.isShuffleMode = false, this.loopMode = LoopMode.off, final  List<int> shuffleIndices = const <int>[], this.isPlaying = false, this.isLoading = false, this.isError = false, this.errorMessage = ''}): _playlist = playlist,_shuffleIndices = shuffleIndices,super._();
  

 final  List<TrackModel> _playlist;
@override@JsonKey() List<TrackModel> get playlist {
  if (_playlist is EqualUnmodifiableListView) return _playlist;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_playlist);
}

@override@JsonKey() final  int currentIndex;
@override@JsonKey() final  bool isShuffleMode;
@override@JsonKey() final  LoopMode loopMode;
 final  List<int> _shuffleIndices;
@override@JsonKey() List<int> get shuffleIndices {
  if (_shuffleIndices is EqualUnmodifiableListView) return _shuffleIndices;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_shuffleIndices);
}

@override@JsonKey() final  bool isPlaying;
@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isError;
@override@JsonKey() final  String errorMessage;

/// Create a copy of PlayerBlocState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlayerBlocStateCopyWith<_PlayerBlocState> get copyWith => __$PlayerBlocStateCopyWithImpl<_PlayerBlocState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlayerBlocState&&const DeepCollectionEquality().equals(other._playlist, _playlist)&&(identical(other.currentIndex, currentIndex) || other.currentIndex == currentIndex)&&(identical(other.isShuffleMode, isShuffleMode) || other.isShuffleMode == isShuffleMode)&&(identical(other.loopMode, loopMode) || other.loopMode == loopMode)&&const DeepCollectionEquality().equals(other._shuffleIndices, _shuffleIndices)&&(identical(other.isPlaying, isPlaying) || other.isPlaying == isPlaying)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isError, isError) || other.isError == isError)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_playlist),currentIndex,isShuffleMode,loopMode,const DeepCollectionEquality().hash(_shuffleIndices),isPlaying,isLoading,isError,errorMessage);

@override
String toString() {
  return 'PlayerBlocState(playlist: $playlist, currentIndex: $currentIndex, isShuffleMode: $isShuffleMode, loopMode: $loopMode, shuffleIndices: $shuffleIndices, isPlaying: $isPlaying, isLoading: $isLoading, isError: $isError, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$PlayerBlocStateCopyWith<$Res> implements $PlayerBlocStateCopyWith<$Res> {
  factory _$PlayerBlocStateCopyWith(_PlayerBlocState value, $Res Function(_PlayerBlocState) _then) = __$PlayerBlocStateCopyWithImpl;
@override @useResult
$Res call({
 List<TrackModel> playlist, int currentIndex, bool isShuffleMode, LoopMode loopMode, List<int> shuffleIndices, bool isPlaying, bool isLoading, bool isError, String errorMessage
});




}
/// @nodoc
class __$PlayerBlocStateCopyWithImpl<$Res>
    implements _$PlayerBlocStateCopyWith<$Res> {
  __$PlayerBlocStateCopyWithImpl(this._self, this._then);

  final _PlayerBlocState _self;
  final $Res Function(_PlayerBlocState) _then;

/// Create a copy of PlayerBlocState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? playlist = null,Object? currentIndex = null,Object? isShuffleMode = null,Object? loopMode = null,Object? shuffleIndices = null,Object? isPlaying = null,Object? isLoading = null,Object? isError = null,Object? errorMessage = null,}) {
  return _then(_PlayerBlocState(
playlist: null == playlist ? _self._playlist : playlist // ignore: cast_nullable_to_non_nullable
as List<TrackModel>,currentIndex: null == currentIndex ? _self.currentIndex : currentIndex // ignore: cast_nullable_to_non_nullable
as int,isShuffleMode: null == isShuffleMode ? _self.isShuffleMode : isShuffleMode // ignore: cast_nullable_to_non_nullable
as bool,loopMode: null == loopMode ? _self.loopMode : loopMode // ignore: cast_nullable_to_non_nullable
as LoopMode,shuffleIndices: null == shuffleIndices ? _self._shuffleIndices : shuffleIndices // ignore: cast_nullable_to_non_nullable
as List<int>,isPlaying: null == isPlaying ? _self.isPlaying : isPlaying // ignore: cast_nullable_to_non_nullable
as bool,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isError: null == isError ? _self.isError : isError // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: null == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
