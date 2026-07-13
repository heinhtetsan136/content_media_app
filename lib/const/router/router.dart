import 'package:go_router/go_router.dart';
import 'package:media_content_library/feature/audio/ui/screen/audio_screen.dart';
import 'package:media_content_library/feature/blog/ui/screen/blog_screen.dart';
import 'package:media_content_library/feature/pdf/ui/screen/pdf_screen.dart';
import 'package:media_content_library/feature/setting/ui/screen/settings_screen.dart';
import 'package:media_content_library/feature/ui/home/home.dart';
import 'package:media_content_library/feature/video/ui/screen/video_screen.dart';

GoRouter goRoute = GoRouter(
  initialLocation: "/",
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context,state,shell){

        return Home(shell: shell);
      },
      branches: [
        StatefulShellBranch(

          routes: [
            GoRoute(path: "/", name: "home",builder: (context,state){
              return BlogScreen();
            }),

          ],
        ),
        StatefulShellBranch(

          routes: [
            GoRoute(path: "/audio", name: "audio",builder: (context,state){
              return AudioScreen();
            }),

          ],
        ),
        StatefulShellBranch(

          routes: [
            GoRoute(path: "/video", name: "video",builder: (context,state){
              return VideoScreen();
            }),

          ],
        ),
        StatefulShellBranch(

          routes: [
            GoRoute(path: "/pdf", name: "pdf",builder: (context,state){
              return PdfScreen();
            }),

          ],
        ),
        StatefulShellBranch(

          routes: [
            GoRoute(path: "/settings", name: "settings",builder: (context,state){
              return SettingsScreen();
            }),

          ],
        ),
      ],
    ),
  ],
);
