import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
class MyBottomNavigation extends StatefulWidget {
  final  StatefulNavigationShell shell;
  const MyBottomNavigation({super.key,required this.shell});

  @override
  State<MyBottomNavigation> createState() => _MyBottomNavigationState();
}

class _MyBottomNavigationState extends State<MyBottomNavigation> {
  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: widget.shell.currentIndex,
        onDestinationSelected: (i){
        widget.shell.goBranch(i);
        },

        destinations: [
      NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
      NavigationDestination(icon: Icon(Icons.audio_file  ), label: "Audio"),
      NavigationDestination(icon: Icon(Icons.video_library), label: "Video"),
      NavigationDestination(icon: Icon(Icons.picture_as_pdf), label: "Pdf"),
      NavigationDestination(icon: Icon(Icons.settings), label: "Settings" ),

    ]);

  }
}
