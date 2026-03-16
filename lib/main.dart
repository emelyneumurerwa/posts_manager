import 'package:flutter/material.dart';
import 'screens/posts_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Posts Manager',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: const Color(0xFF3E1C00),
        useMaterial3: true,
      ),
      home: const PostsListScreen(),
    );
  }
}
