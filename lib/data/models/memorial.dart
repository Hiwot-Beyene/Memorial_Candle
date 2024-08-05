class Memorial {
  final int id;
  final String title;
  final String description;
  final String imgUrl;
  final String personName;
  final String birthdate;
  final String deathday;

  Memorial({
    required this.id,
    required this.title,
    required this.description,
    required this.imgUrl,
    required this.personName,
    required this.birthdate,
    required this.deathday,
  });

  factory Memorial.fromJson(Map<String, dynamic> json) {
    return Memorial(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      imgUrl: json['imgUrl'],
      personName: json['personName'],
      birthdate: json['birthdate'],
      deathday: json['deathday'],
    );
  }
}
