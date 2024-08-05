import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

Future<List<dynamic>> loadJsonData() async {
  final jsonString = await rootBundle.loadString('assets/memorial_data.json');
  return json.decode(jsonString);
}
