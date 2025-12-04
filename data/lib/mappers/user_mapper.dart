import 'package:domain/domain.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class UserMapper {
  static UserModel toModel(User user) {
    return UserModel(
      id: user.id,
      email: user.email!,
      avatarUrl: user.userMetadata?['avatar_url'],
    );
  }
}
