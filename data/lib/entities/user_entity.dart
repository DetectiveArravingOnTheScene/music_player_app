import 'package:supabase_flutter/supabase_flutter.dart';

class UserEntity {
  final String id;
  final String email;
  final String? avatarUrl;

  const UserEntity({required this.id, required this.email, this.avatarUrl});

  factory UserEntity.fromSupabase(User user) {
    return UserEntity(
      id: user.id,
      email: user.email ?? '',
      avatarUrl: user.userMetadata?['avatar_url'],
    );
  }
}
