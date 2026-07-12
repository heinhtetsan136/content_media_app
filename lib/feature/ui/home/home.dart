import 'package:flutter/material.dart';
import 'package:media_content_library/feature/blog/ui/blog_screen.dart';
import 'package:media_content_library/feature/ui/widget/bottom_navigation.dart';
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Media Content Library"),
      ),
      body: BlogScreen(),
      bottomNavigationBar: MyBottomNavigation(),
    );
  }
}
