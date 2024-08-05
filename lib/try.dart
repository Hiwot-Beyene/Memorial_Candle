// import 'package:flutter/material.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: MemorialListPage(),
//     );
//   }
// }

// class MemorialListPage extends StatelessWidget {
//   Future<List<dynamic>> fetchData() async {
//     final data = await loadJsonData();
//     return data;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Memorial List')),
//       body: FutureBuilder<List<dynamic>>(
//         future: fetchData(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Center(child: Text('No Data Found'));
//           } else {
//             return ListView.builder(
//               itemCount: snapshot.data!.length,
//               itemBuilder: (context, index) {
//                 final item = snapshot.data![index];
//                 return ListTile(
//                   leading: Image.network(item['imgUrl']),
//                   title: Text(item['title']),
//                   subtitle: Text(item['description']),
//                   trailing: IconButton(
//                     icon: Icon(Icons.details),
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => MemorialDetailsPage(item: item),
//                         ),
//                       );
//                     },
//                   ),
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }
