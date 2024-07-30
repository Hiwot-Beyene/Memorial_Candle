import 'package:flutter/material.dart';

class SquareTile extends StatelessWidget {
  final String imagePath;
  const SquareTile({
    Key? key,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromARGB(255, 173, 53, 53)),
        borderRadius: BorderRadius.circular(16),
        color: Colors.grey[100],
      ),
      width: 64.0, // Set your desired width here
      height: 64.0, // Set your desired height here
      child: Image.asset(imagePath),
    );
  }
}
