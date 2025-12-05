class UserModel {
  final String id;
  final String email;
  final String? avatarUrl;

  const UserModel({required this.id, required this.email, this.avatarUrl});
}
