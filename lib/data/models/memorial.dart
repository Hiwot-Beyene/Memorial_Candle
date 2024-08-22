class Memorial {
  final String id;
  final String personName;
  final String description;
  final String imageUrl;
  final DateTime birthDate;
  final DateTime deceasedDate;
  final String userId;
  final String displayName;

  Memorial({
    required this.id,
    required this.personName,
    required this.description,
    required this.imageUrl,
    required this.birthDate,
    required this.deceasedDate,
    required this.userId,
    required this.displayName,
  });

  factory Memorial.fromJson(Map<String, dynamic> json) {
  return Memorial(
    id: json['_id'] ?? '',  
    personName: json['person_name'] ?? 'Unknown',
    description: json['description'] ?? 'No description available',
    imageUrl: json['image_url'] ?? '',  // Handle optional image URL
    birthDate: json['birth_date'] != null ? DateTime.parse(json['birth_date']) : DateTime(1970, 1, 1), // Default to a specific date
    deceasedDate: json['deceased_date'] != null ? DateTime.parse(json['deceased_date']) : DateTime(1970, 1, 1), // Default to a specific date
    userId: json['user_id']?['_id'] ?? '',  // Safely access nested user_id and provide a default value
    displayName: json['user_id']?['displayName'] ?? 'Unknown',  // Safely access displayName
  );
}

}
