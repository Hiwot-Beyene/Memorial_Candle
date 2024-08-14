import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingSkeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          Container(
            height: 40.0,
            color: Colors.grey,
          ),
          SizedBox(height: 16.0),
          Container(
            height: 40.0,
            color: Colors.grey,
          ),
          SizedBox(height: 16.0),
          Container(
            height: 40.0,
            color: Colors.grey,
          ),
          SizedBox(height: 16.0),
          Container(
            height: 40.0,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
