import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:silent_habit/models/post.dart';

const API_URL = 'https://dummyjson.com';

class Api {
  Future<List<Post>> fetchPosts() async {
    final uri = Uri.parse('$API_URL/posts');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      final List<dynamic> postsData = jsonData['posts'];
      return postsData.map((json) => Post.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }
}
