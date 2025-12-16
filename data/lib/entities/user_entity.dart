import 'package:core/core.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'gen/user_entity.freezed.dart';
part 'gen/user_entity.g.dart';

@Freezed()
abstract class UserEntity with _$UserEntity {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory UserEntity({
    required String id,
    required String email,
    String? avatarUrl,
  }) = _UserEntity;

  const UserEntity._();

  factory UserEntity.fromJson(Map<String, dynamic> json) =>
      _$UserEntityFromJson(json);

  factory UserEntity.fromSupabase(User user) {
    return UserEntity(
      id: user.id,
      email: user.email ?? '',
      avatarUrl: user.userMetadata?['avatar_url'] as String?,
    );
  }
}
