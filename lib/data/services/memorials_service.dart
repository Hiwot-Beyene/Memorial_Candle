import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:lightforisrael/data/models/memorial.dart';

class MemorialService {
  final String baseUrl =
      "http://testcandlelight-env.eba-zj8s4m9b.eu-north-1.elasticbeanstalk.com/api/v1/memorials";

  // Fetch all memorials
 Future<List<Memorial>> fetchMemorials({int page = 1, int limit = 10}) async {
    final response = await http.get(Uri.parse('$baseUrl?page=$page&limit=$limit'));

    if (response.statusCode == 200) {
      Map<String, dynamic> body = json.decode(response.body);
      List<dynamic> memorialsJson = body['memorials'];
      List<Memorial> memorials =
          memorialsJson.map((dynamic item) => Memorial.fromJson(item)).toList();
      return memorials;
    } else {
      throw Exception('Failed to load memorials');
    }
  }

  // Fetch a memorial by ID
  Future<Memorial> fetchMemorialById(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/$id'));

    if (response.statusCode == 200) {
      return Memorial.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load memorial');
    }
  }

    // Create a new memorial with named parameters
  Future<void> createMemorial({
  required String personName,
  required String description,
  required DateTime birthDate,
  required DateTime deceasedDate,
  required File imageFile,
}) async {
  final uri = Uri.parse('http://testcandlelight-env.eba-zj8s4m9b.eu-north-1.elasticbeanstalk.com/api/v1/memorials/');
  final request = http.MultipartRequest('POST', uri);

  request.fields['person_name'] = personName;
  request.fields['description'] = description;
  request.fields['birth_date'] = birthDate.toIso8601String();
  request.fields['deceased_date'] = deceasedDate.toIso8601String();

 
  request.files.add(await http.MultipartFile.fromPath(
    'memorialImage', 
    imageFile.path,
  ));

  final response = await request.send();

  if (response.statusCode == 201) {
    print('Memorial created successfully');
  } else {
    final responseString = await response.stream.bytesToString();
    print('Failed to create memorial: $responseString');
    throw Exception('Failed to create memorial: $responseString');
  }
}
}