import 'package:freezed_annotation/freezed_annotation.dart';

part 'gen/collection_entity.freezed.dart';
part 'gen/collection_entity.g.dart';

@Freezed(genericArgumentFactories: true)
abstract class CollectionEntity<T> with _$CollectionEntity<T> {
  const factory CollectionEntity({
    required List<T> collection,
    @JsonKey(name: 'next_href') String? nextHref,
  }) = _CollectionEntity<T>;

  // It now accepts a second argument: a function to deserialize T.
  factory CollectionEntity.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) => _$CollectionEntityFromJson(json, fromJsonT);
}
