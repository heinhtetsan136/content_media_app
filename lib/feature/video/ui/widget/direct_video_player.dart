import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class DirectVideoPlayer extends StatefulWidget {
  final String link;

  const DirectVideoPlayer({
    super.key,
    required this.link,
  });

  @override
  State<DirectVideoPlayer> createState() =>
      _DirectVideoPlayerState();
}

class _DirectVideoPlayerState
    extends State<DirectVideoPlayer> {
  late VideoPlayerController
  videoPlayerController;
  @override
  void dispose() {
    videoPlayerController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    videoPlayerController =
        VideoPlayerController.networkUrl(
          Uri.parse(widget.link),
        );
    videoPlayerController.initialize().then((_) {
      setState(() {});
    });
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return videoPlayerController
            .value
            .isInitialized
        ? Column(
            children: [
              AspectRatio(
                aspectRatio: videoPlayerController
                    .value
                    .aspectRatio,

                child: VideoPlayer(
                  videoPlayerController,
                ),
              ),
              SizedBox(height: 8),
              ValueListenableBuilder(
                valueListenable:
                    videoPlayerController,
                builder: (_, value, child) {
                  final totalTime = value
                      .duration
                      .inSeconds
                      .toDouble();
                  final currentTime = value
                      .position
                      .inSeconds
                      .toDouble();
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(_formatDuration(currentTime)),
                          Text(_formatDuration(totalTime))
                        ],

                      ),
                      Slider(
                        max: totalTime,
                        value: currentTime,
                        onChanged: totalTime > 0
                            ? (v) {
                                videoPlayerController
                                    .seekTo(
                                      Duration(
                                        seconds: v
                                            .toInt(),
                                      ),
                                    );
                              }
                            : null,
                      ),
                    ],
                  );
                },
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    videoPlayerController
                            .value
                            .isPlaying
                        ? videoPlayerController
                              .pause()
                        : videoPlayerController
                              .play();
                  });
                },
                icon:
                    videoPlayerController
                        .value
                        .isPlaying
                    ? Icon(Icons.pause)
                    : Icon(
                        Icons.play_arrow_outlined,
                      ),
              ),
            ],
          )
        : Container(
            height: 300,
            alignment: Alignment.center,
            child: CircularProgressIndicator(),
          );
  }
  String _formatDuration(double seconds){
    Duration duration = Duration(seconds: seconds.toInt());
    int hour = duration.inHours;
    String minute = duration.inMinutes.remainder(60).toString().padLeft(2,'0');
    String second = duration.inSeconds.remainder(60).toString().padLeft(2,'0');
    if(hour >0) return "$hour:$minute:$second";
    return "$minute:$second";
  }
}
