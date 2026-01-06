import 'package:core/core.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../abstract/user_entity.dart';

part 'gen/cloud_user_entity.freezed.dart';
part 'gen/cloud_user_entity.g.dart';

@Freezed()
abstract class CloudUserEntity with _$CloudUserEntity implements UserEntity {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory CloudUserEntity({
    required String id,
    required String email,
    String? avatarUrl,
  }) = _CloudUserEntity;

  const CloudUserEntity._();

  factory CloudUserEntity.fromJson(Map<String, dynamic> json) =>
      _$CloudUserEntityFromJson(json);

  factory CloudUserEntity.fromSupabase(User user) {
    return CloudUserEntity(
      id: user.id,
      email: user.email ?? '',
      avatarUrl: user.userMetadata?['avatar_url'] as String?,
    );
  }
}
