import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:media_content_library/const/api_const/api_const.dart';
import 'package:media_content_library/feature/audio/ui/screen/audio_screen.dart';
import 'package:media_content_library/feature/audio/ui/screen/detail/audio_detail.dart';
import 'package:media_content_library/feature/blog/ui/screen/blog_detail_screen.dart';
import 'package:media_content_library/feature/blog/ui/screen/blog_screen.dart';
import 'package:media_content_library/feature/pdf/ui/screen/pdf_screen.dart';
import 'package:media_content_library/feature/setting/ui/screen/settings_screen.dart';
import 'package:media_content_library/feature/ui/home/home.dart';
import 'package:media_content_library/feature/video/ui/screen/video_screen.dart';
import 'package:media_content_library/feature/video/ui/video_detail/video_detail.dart';

import '../../feature/pdf/ui/screen/pdf_detail.dart';

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
    GoRoute(path: "/details/:type/:id",builder: (_,state){
      String? type=state.pathParameters["type"];
      String? id=state.pathParameters["id"];
     if(type==ApiConst.blog){
       return BlogDetailScreen(type: type, id: id);
     }
     else if(type==ApiConst.audio){
       return AudioDetail(id: id,);
     }
     else if(type==ApiConst.video){
       return VideoDetail(id: id);
     }
     else if(type==ApiConst.pdf){
       return PdfDetail(id:id);
     }
     return Scaffold(body: Text("error"));
    }),

  ],
);
