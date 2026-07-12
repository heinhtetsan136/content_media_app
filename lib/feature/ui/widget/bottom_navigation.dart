import 'package:flutter/material.dart';
class MyBottomNavigation extends StatefulWidget {
  const MyBottomNavigation({super.key});

  @override
  State<MyBottomNavigation> createState() => _MyBottomNavigationState();
}

class _MyBottomNavigationState extends State<MyBottomNavigation> {
  @override
  Widget build(BuildContext context) {
    return NavigationBar(destinations: [
      NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
      NavigationDestination(icon: Icon(Icons.audio_file  ), label: "Audio"),
      NavigationDestination(icon: Icon(Icons.video_library), label: "Video"),
      NavigationDestination(icon: Icon(Icons.settings), label: "Settings" ),

    ]);

  }
}
