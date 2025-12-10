import 'package:domain/domain.dart';

import '../data.dart';

abstract class UserMapper {
  static UserModel toModel(UserEntity user) {
    return UserModel(id: user.id, email: user.email, avatarUrl: user.avatarUrl);
  }
}
