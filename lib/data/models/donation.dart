import 'package:flutter/foundation.dart';

class Donation {
  final String id;
  final String memorialId;
  final String? userId; // Optional field
  final String donatedBy;
  final String personalWord;
  final double amount;
  final String stripeSessionId;
  final DateTime createdAt;
  final DateTime updatedAt;

  Donation({
    required this.id,
    required this.memorialId,
    this.userId,
    required this.donatedBy,
    required this.personalWord,
    required this.amount,
    required this.stripeSessionId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Donation.fromJson(Map<String, dynamic> json) {
    return Donation(
      id: json['_id'] ?? '',
      memorialId: json['memorial_id'] ?? '',
      userId: json['user_id']?['_id'], 
      donatedBy: json['donated_by'] ?? 'Anonymous',
      personalWord: json['personal_word'] ?? '',
      amount: json['amount']?.toDouble() ?? 0.0,
      stripeSessionId: json['stripeSessionId'] ?? '',
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : DateTime.now(),
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'memorial_id': memorialId,
      'user_id': userId != null ? {'_id': userId} : null,
      'donated_by': donatedBy,
      'personal_word': personalWord,
      'amount': amount,
      'stripeSessionId': stripeSessionId,
      'createdAt': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
