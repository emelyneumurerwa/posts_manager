import 'package:flutter/material.dart';
import '../models/post.dart';
import 'edit_post_screen.dart';

class PostDetailScreen extends StatelessWidget {
  final Post post;
  const PostDetailScreen({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text('Post Details'),
        backgroundColor: const Color(0xFF3E1C00),
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => EditPostScreen(post: post)),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFF3E1C00).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Post #${post.id}  •  User ${post.userId}',
                style: const TextStyle(
                  color: Color(0xFF3E1C00),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              post.title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 12),
            Text(
              post.body,
              style: const TextStyle(
                fontSize: 16,
                height: 1.6,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
