class Memorial {
  final String id;
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
      id: json['id'] ?? '', 
      title: json['title'] ?? 'No Title',
      description: json['description'] ?? 'No Description',
      imgUrl: json['imgUrl'] ?? '',
      personName: json['personName'] ?? 'Unknown Person',
      birthdate: json['birthdate'] ?? '',
      deathday: json['deathday'] ?? '',
    );
  }
}
