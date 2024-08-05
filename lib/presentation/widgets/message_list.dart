import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:lightforisrael/data/models/memorial.dart';
import 'package:lightforisrael/data/models/message.dart';
import 'package:lightforisrael/data/models/user.dart';
import 'package:lightforisrael/presentation/widgets/message_card.dart';

class MessageList extends StatefulWidget {
  @override
  _MessageListState createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  late Future<List<Message>> messages;
  late List<User> users;
  late List<Memorial> memorials;

  @override
  void initState() {
    super.initState();
    messages = fetchMessages();
  }

  Future<List<Message>> fetchMessages() async {
    final responseMessages = await rootBundle.loadString('assets/messages.json');
    final responseUsers = await rootBundle.loadString('assets/users.json');
    final responseMemorials = await rootBundle.loadString('assets/memorial_data.json');

    List<dynamic> messageJson = json.decode(responseMessages);
    List<dynamic> userJson = json.decode(responseUsers);
    List<dynamic> memorialJson = json.decode(responseMemorials);

    users = userJson.map((data) => User.fromJson(data)).toList();
    memorials = memorialJson.map((data) => Memorial.fromJson(data)).toList();

    return messageJson.map((data) {
      return Message.fromJson(data);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Message>>(
      future: messages,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No messages found.'));
        } else {
          List<Message> messages = snapshot.data!;
          return ListView.builder(
            itemCount: messages.length,
            itemBuilder: (context, index) {
              Message message = messages[index];
              User user = users.firstWhere((user) => user.id == message.userId);
              // Memorial memorial = memorials.firstWhere((memorial) => memorial.id == message.memorialId);

              return MessageCard(userName: user.name, userEmail: user.email, userImage: user.imgUrl,  messageContent: message.content, amount: message.amount);
            },
          );
        }
      },
    );
  }
}
