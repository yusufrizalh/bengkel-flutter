class User {
  final int id;
  final String user_name;
  final String user_email;
  final String token;

  User({
    required this.id,
    required this.user_name,
    required this.user_email,
    required this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      user_name: json['user_name'],
      user_email: json['user_email'],
      token: json['token'],
    );
  }
}
