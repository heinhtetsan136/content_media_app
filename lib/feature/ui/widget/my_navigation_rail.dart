import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../const/responsive/responsive_util.dart';
class MyNavigationRail extends StatelessWidget {
  final StatefulNavigationShell shell;
  const MyNavigationRail({super.key, required this.shell});

  @override
  Widget build(BuildContext context) {
    final bool isMobile= ResponsiveUtil.isMoblie(context);
    return Row(
      children: [
        !isMobile? NavigationRail(
            extended: ResponsiveUtil.isDesktop(context),
            labelType:ResponsiveUtil.isDesktop(context)?NavigationRailLabelType.none: NavigationRailLabelType.all,
            onDestinationSelected: (i){
             shell.goBranch(i);
            },
            destinations: [
              NavigationRailDestination(icon: Icon(Icons.home), label: Text("Home")),
              NavigationRailDestination(icon: Icon(Icons.audio_file  ), label:Text("Audio")),
              NavigationRailDestination(icon: Icon(Icons.video_library), label: Text("Video")),
              NavigationRailDestination(icon: Icon(Icons.picture_as_pdf), label: Text("Pdf")),
              NavigationRailDestination(icon: Icon(Icons.settings), label: Text("Settings") ),
            ], selectedIndex: shell.currentIndex):SizedBox(),
        !isMobile?VerticalDivider():SizedBox(),
        Expanded(child: shell),
      ],
    );
  }
}
