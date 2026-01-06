import 'package:isar_plus/isar_plus.dart';

import '../abstract/user_entity.dart';

part 'gen/local_user_entity.g.dart';

@Collection()
class LocalUserEntity implements UserEntity {
  LocalUserEntity({required this.id});

  @override
  final String id;

  @override
  late String email;

  @override
  late String? avatarUrl;
}
