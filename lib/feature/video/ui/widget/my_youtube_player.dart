import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class MyYoutubePlayer extends StatefulWidget {
  final String url;
  const MyYoutubePlayer({
    super.key,
    required this.url,
  });

  @override
  State<MyYoutubePlayer> createState() =>
      _MyYoutubePlayerState();
}

class _MyYoutubePlayerState
    extends State<MyYoutubePlayer> {
  late YoutubePlayerController
  youtubePlayerController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    youtubePlayerController =
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
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(controller: youtubePlayerController);
  }
}
