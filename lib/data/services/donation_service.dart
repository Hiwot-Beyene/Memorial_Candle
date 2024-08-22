import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lightforisrael/data/models/donation.dart';

class DonationService {
  final String baseUrl =
      "http://testcandlelight-env.eba-zj8s4m9b.eu-north-1.elasticbeanstalk.com/api/v1/donations";

  // Fetch all donations
  Future<Map<String, dynamic>> fetchDonations({int page = 1, int limit = 10}) async {
    final response = await http.get(Uri.parse('$baseUrl?page=$page&limit=$limit'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load donations');
    }
  }

  // Fetch donations by memorial ID
  Future<Map<String, dynamic>> fetchDonationsByMemorialId(String memorialId, {int page = 1, int limit = 10}) async {
    final response = await http.get(Uri.parse('$baseUrl/memorials/$memorialId?page=$page&limit=$limit'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load donations for memorial');
    }
  }

  // Fetch a single donation by ID
  Future<Donation> fetchDonationById(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/$id'));

    if (response.statusCode == 200) {
      return Donation.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load donation');
    }
  }

  // Create a new donation
  Future<void> createDonation({
    required String memorialId,
    String? userId,
    required String donatedBy,
    required String personalWord,
    required double amount,
    required String stripeSessionId,
  }) async {
    final uri = Uri.parse(baseUrl);
    final response = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'memorial_id': memorialId,
        'user_id': userId,
        'donated_by': donatedBy,
        'personal_word': personalWord,
        'amount': amount,
        'stripeSessionId': stripeSessionId,
      }),
    );

    if (response.statusCode == 201) {
      print('Donation created successfully');
    } else {
      final responseString = response.body;
      print('Failed to create donation: $responseString');
      throw Exception('Failed to create donation: $responseString');
    }
  }

}
 