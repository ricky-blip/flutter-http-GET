class UserModel {
  final String username;
  final String password;
  final String id;

  const UserModel({
    required this.username,
    required this.password,
    required this.id,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      username: json['username'],
      password: json['password'],
      id: json['id'],
    );
  }
}
