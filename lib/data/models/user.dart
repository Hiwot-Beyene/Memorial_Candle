class User {
  final String id;
  final String name;
  final String email;
  final String imgUrl;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.imgUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['user_id'] ?? '',
      name: json['name'] ?? 'Unknown', 
      email: json['email'] ?? '', 
      imgUrl: json['imgUrl'] ?? '', 
    );
  }
}
