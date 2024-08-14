import 'package:flutter/material.dart';

class MessageCard extends StatelessWidget {
  final String userName;
  final String userEmail;
  final String userImage;
  final String messageContent;
  final double amount;

  const MessageCard({
    required this.userName,
    required this.userEmail,
    required this.userImage,
    required this.messageContent,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black,
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(userImage),
                  radius: 30,
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userName,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                      ),
                      Text(
                        userEmail,
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      SizedBox(height: 4.0),
                      // Text(
                      //   memorialTitle,
                      //   style: TextStyle(fontStyle: FontStyle.italic, color: Colors.blueGrey[800]),
                      // ),
                      SizedBox(height: 4.0),
                      
                      SizedBox(height: 4.0),
                      Text(
                        'Amount: \$${amount.toStringAsFixed(2)}',
                        style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red),
                      ),
                      Text(
                    messageContent,
                  ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
