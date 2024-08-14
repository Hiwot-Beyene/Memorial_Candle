import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Future<bool?> showConfirmationDialog(BuildContext context, String title, String content) async {
  return showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop(false); 
            },
          ),
          TextButton(
            child: Text('Logout'),
            onPressed: () {
              GoRouter.of(context).go('/login');
            },
          ),
        ],
      );
    },
  );
}
