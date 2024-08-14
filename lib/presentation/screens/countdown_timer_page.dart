// import 'package:flutter/material.dart';
// import 'package:flutter_gifimage/flutter_gifimage.dart'; // For local GIFs
// // import 'package:cached_network_image/cached_network_image.dart'; // For network GIFs
// import 'package:timer_count_down/timer_count_down.dart';
// class CountdownTimerPage extends StatefulWidget {
//   @override
//   _CountdownTimerPageState createState() => _CountdownTimerPageState();
// }

// class _CountdownTimerPageState extends State<CountdownTimerPage> {
//   final int endTime = DateTime.now().add(Duration(minutes: 1)).millisecondsSinceEpoch; // Set countdown end time

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Countdown Timer'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             CountdownTimer(
//               endTime: endTime,
//               onEnd: () {
//                 setState(() {
//                   // Trigger the state update to show GIF
//                 });
//               },
//               widgetBuilder: (_, CurrentRemainingTime? time) {
//                 if (time == null) {
//                   // Countdown finished
//                   return Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text('Countdown Ended', style: TextStyle(fontSize: 24)),
//                       SizedBox(height: 20),
//                       // For local GIF
//                       // GifImage(
//                       //   controller: GifController(vsync: this),
//                       //   image: AssetImage('assets/celebration.gif'),
//                       // ),
//                       // For network GIF
//                       // CachedNetworkImage(
//                       //   imageUrl: 'https://example.com/celebration.gif',
//                       //   placeholder: (context, url) => CircularProgressIndicator(),
//                       // ),
//                       // If you want to show a static image or widget as a fallback
//                       // Image.asset('assets/celebration.png'),
//                     ],
//                   );
//                 } else {
//                   return Text(
//                     'Time Remaining: ${time.days ?? 0}d ${time.hours ?? 0}h ${time.min ?? 0}m ${time.sec ?? 0}s',
//                     style: TextStyle(fontSize: 24),
//                   );
//                 }
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
