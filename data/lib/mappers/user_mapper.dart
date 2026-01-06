import 'package:domain/domain.dart';

import '../entities/abstract/user_entity.dart';

abstract class UserMapper {
  static UserModel toModel(UserEntity user) {
    return UserModel(id: user.id, email: user.email, avatarUrl: user.avatarUrl);
  }
}
