import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_content_library/feature/ui/widget/failed_widget.dart';
import 'package:media_content_library/feature/video/data/video_model.dart';
import 'package:media_content_library/feature/video/notifier/video_notifier.dart';
import 'package:media_content_library/feature/video/notifier/video_state_model.dart';
import 'package:media_content_library/feature/video/ui/widget/video_item.dart';

class VideoScreen extends ConsumerStatefulWidget {
  const VideoScreen({super.key});

  @override
  ConsumerState<VideoScreen> createState() =>
      _VideoScreenState();
}

class _VideoScreenState
    extends ConsumerState<VideoScreen> {
  final VideoProvider videoProvider =
      VideoProvider(() => VideoNotifier());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((
      _,
    ) {
      ref.read(videoProvider.notifier).getAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    VideoStateModel videoStateModel = ref.watch(
      videoProvider,
    );
    if (videoStateModel.isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    if (videoStateModel.isError) {
      return FailedWidget(
        ref: ref,
        onTry: () {
          ref
              .read(videoProvider.notifier)
              .getAll();
        },
      );
    }
    List<VideoData> videoData =
        videoStateModel.model?.data ?? [];
    return ListView.builder(
      itemCount: videoData.length,
      itemBuilder: (_, i) {
        final VideoData video = videoData[i];
        return VideoItem(
          data: video,
          colorScheme: Theme.of(
            context,
          ).colorScheme,
        );
      },
    );
  }
}
