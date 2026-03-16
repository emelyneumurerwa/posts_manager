import 'package:flutter/material.dart';
import '../models/post.dart';
import '../services/api_service.dart';
import 'post_detail_screen.dart';
import 'create_post_screen.dart';

class PostsListScreen extends StatefulWidget {
  const PostsListScreen({super.key});

  @override
  State<PostsListScreen> createState() => _PostsListScreenState();
}

class _PostsListScreenState extends State<PostsListScreen> {
  final ApiService _apiService = ApiService();
  late Future<List<Post>> _postsFuture;

  @override
  void initState() {
    super.initState();
    _postsFuture = _apiService.fetchPosts();
  }

  void _refresh() {
    setState(() {
      _postsFuture = _apiService.fetchPosts();
    });
  }

  Future<void> _deletePost(int id) async {
    try {
      await _apiService.deletePost(id);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Post deleted successfully')),
      );
      _refresh();
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text(
          'Posts Manager',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        backgroundColor: const Color(0xFF3E1C00),
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: _refresh),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const CreatePostScreen()),
          );
          _refresh();
        },
        backgroundColor: const Color(0xFF3E1C00),
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('New Post'),
      ),
      body: FutureBuilder<List<Post>>(
        future: _postsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF3E1C00)),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 60, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    'Error: ${snapshot.error}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.red),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _refresh,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }
          final posts = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 10),
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  leading: CircleAvatar(
                    backgroundColor: const Color(0xFF3E1C00),
                    child: Text(
                      '${post.id}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  title: Text(
                    post.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                  subtitle: Text(
                    post.body,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.grey),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline, color: Colors.red),
                    onPressed: () => _deletePost(post.id),
                  ),
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PostDetailScreen(post: post),
                      ),
                    );
                    _refresh();
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
