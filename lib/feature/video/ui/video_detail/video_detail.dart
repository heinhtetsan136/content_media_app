import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_content_library/feature/ui/widget/failed_widget.dart';
import 'package:media_content_library/feature/video/data/video_model.dart';
import 'package:media_content_library/feature/video/notifier/detail/video_detail_notifier.dart';
import 'package:media_content_library/feature/video/notifier/detail/video_detail_state_model.dart';
import 'package:media_content_library/feature/video/ui/widget/direct_video_player.dart';
import 'package:media_content_library/feature/video/ui/widget/my_youtube_player.dart';
import 'package:media_content_library/feature/video/ui/widget/web_youtube_player.dart';

class VideoDetail extends ConsumerStatefulWidget {
  final String? id;
  const VideoDetail({
    super.key,
    required this.id,
  });

  @override
  ConsumerState<VideoDetail> createState() =>
      _VideoDetailState();
}

class _VideoDetailState
    extends ConsumerState<VideoDetail> {
  final VideoDetailProvider videoDetailProvider =
      VideoDetailProvider(
        () => VideoDetailNotifier(),
      );
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((
      _,
    ) {
      ref
          .read(videoDetailProvider.notifier)
          .getVideo(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {

    VideoDetailStateModel videoDetailStateModel =
        ref.watch(videoDetailProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          videoDetailStateModel
                  .videoData
                  ?.title ??
              "",
        ),
      ),

      body: SingleChildScrollView(child: _videoDetailBody()),
    );
  }

  Widget _videoDetailBody() {
    VideoDetailStateModel videoDetailStateModel =
        ref.watch(videoDetailProvider);
    if (videoDetailStateModel.isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    if (videoDetailStateModel.isError) {
      return FailedWidget(
        ref: ref,
        onTry: () {
          ref
              .read(videoDetailProvider.notifier)
              .getVideo(widget.id);
        },
      );
    }
    VideoData? videoData =
        videoDetailStateModel.videoData;
    final bool isYoutubePlayer=videoData?.source=="youtube"&& videoData?.url!=null;
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 500,
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(videoData?.description ?? ""),
              ),
              if (videoData?.source == "direct" &&
                  videoData?.url != null)
                DirectVideoPlayer(
                  link: videoData?.url ?? "",
                ),

                if(isYoutubePlayer &&kIsWeb )
                MyWebYouTube(url: videoData?.url ??""),
               if(isYoutubePlayer&& !kIsWeb)
               MyYoutubePlayer(url: videoData?.url ??""),
            ],
          ),
        ),
      ),
    );
  }
}
