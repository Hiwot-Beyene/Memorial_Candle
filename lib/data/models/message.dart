class Message {
  final String userId;
  final String memorialId;
  final double amount;
  final String content; 

  Message({
    required this.userId,
    required this.memorialId,
    required this.amount,
    required this.content,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      userId: json['user_id'] ?? '', 
      memorialId: json['memorial_id'] ?? '',
      amount: (json['amount'] ?? 0.0).toDouble(),
      content: json['content'] ?? '', 
    );
  }
}
