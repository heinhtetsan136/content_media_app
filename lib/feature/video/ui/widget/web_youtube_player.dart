import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class MyWebYouTube extends StatefulWidget {
  final String url;
  const MyWebYouTube({super.key, required this.url});

  @override
  State<MyWebYouTube> createState() =>
      _MyWebYouTubeState();
}

class _MyWebYouTubeState extends State<MyWebYouTube> {
  late YoutubePlayerController _controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller =
        YoutubePlayerController.fromVideoId(
          autoPlay: true,
          params: YoutubePlayerParams(
            showFullscreenButton: true,
            mute: false
          ),
          videoId:
              YoutubePlayerController.convertUrlToId(
                widget.url,
              ) ??
              "",
        );

   _controller.playVideo();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(
      controller: _controller,
      // showVideoProgressIndicator: true,
      // progressIndicatorColor: Colors.blueAccent,
      // topActions: <Widget>[
      //   const SizedBox(width: 8.0),
      //   Expanded(
      //     child: Text(
      //       _controller.metadata.title,
      //       style: const TextStyle(
      //         color: Colors.white,
      //         fontSize: 18.0,
      //       ),
      //       overflow: TextOverflow.ellipsis,
      //       maxLines: 1,
      //     ),
      //   ),
      //   IconButton(
      //     icon: const Icon(
      //       Icons.settings,
      //       color: Colors.white,
      //       size: 25.0,
      //     ),
      //     onPressed: () {
      //
      //     },
      //   ),
      // ],
      // onReady: () {
      //
      // },
      // onEnded: (data) {
      //
      // },
    );
  }
}
