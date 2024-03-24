class UserResponse {
  String id;
  String username;
  String password;
  String created_at;
  String updated_at;

  UserResponse({
    required this.id,
    required this.username,
    required this.password,
    required this.created_at,
    required this.updated_at,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      id: json['id'],
      username: json['username'],
      password: json['password'],
      created_at: json['created_at'],
      updated_at: json['updated_at'],
    );
  }
}
