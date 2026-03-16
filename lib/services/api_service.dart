import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/post.dart';

class ApiService {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com/posts';

  // GET all posts
  Future<List<Post>> fetchPosts() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => Post.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load posts. Status: ${response.statusCode}');
      }
    } on http.ClientException {
      throw Exception('Network error: Please check your internet connection.');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  // POST — create a new post
  Future<Post> createPost(String title, String body) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'title': title, 'body': body, 'userId': 1}),
      );
      if (response.statusCode == 201) {
        return Post.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to create post. Status: ${response.statusCode}');
      }
    } on http.ClientException {
      throw Exception('Network error: Please check your internet connection.');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  // PUT — update a post
  Future<Post> updatePost(int id, String title, String body) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/$id'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'id': id, 'title': title, 'body': body, 'userId': 1}),
      );
      if (response.statusCode == 200) {
        return Post.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to update post. Status: ${response.statusCode}');
      }
    } on http.ClientException {
      throw Exception('Network error: Please check your internet connection.');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  // DELETE — remove a post
  Future<void> deletePost(int id) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl/$id'));
      if (response.statusCode != 200) {
        throw Exception('Failed to delete post. Status: ${response.statusCode}');
      }
    } on http.ClientException {
      throw Exception('Network error: Please check your internet connection.');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}