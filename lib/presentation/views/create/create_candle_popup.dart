import 'package:flutter/material.dart';

class CreatePopup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Create Candle'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('Are you sure?'),
         
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
           
            Navigator.of(context).pop();
          },
          child: Text('Create'),
        ),
      ],
    );
  }
}
