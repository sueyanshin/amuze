import 'dart:convert';

import 'package:amuze_app/core/app_constants.dart';
import 'package:amuze_app/models/post.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<String> login({
    required String emailOrPhone,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('${AppConstants.baseUrl}${AppConstants.loginEndpoint}'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({
        "emailOrPhone": emailOrPhone,
        "password": password,
        "firebase_key": "",
      }),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final token = data['token']['access'];
      if (token is String && token.isNotEmpty) {
        return token;
      }
      throw Exception("Token not found in login response");
    }
    throw Exception("Login failed: ${data['message']}");
  }

  Future<List<Post>> getPosts({
    required String token,
    required int page,
    required int pageSize,
  }) async {
    final uri =
        Uri.parse("${AppConstants.baseUrl}${AppConstants.newFeedEndpoint}")
            .replace(
              queryParameters: {
                'page': page.toString(),
                'pageSize': pageSize.toString(),
              },
            );
    print("Requesting URL: $uri");
    final response = await http.get(
      uri,
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final data = jsonDecode(response.body);
      print(data["data"].length);

      final List<dynamic> posts = data['data'];
      return posts
          .map((post) => Post.fromJson(post as Map<String, dynamic>))
          .toList();
    }
    if (response.statusCode == 401) {
      throw Exception('Session expired. Please log in again');
    }
    throw Exception('Failed to load posts: ${response.statusCode}');
  }
}
