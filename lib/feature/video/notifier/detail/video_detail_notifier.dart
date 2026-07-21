import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_content_library/feature/video/data/video_model.dart';
import 'package:media_content_library/feature/video/data/video_service.dart';
import 'package:media_content_library/feature/video/notifier/detail/video_detail_state_model.dart';

import '../../../../const/api_const/api_const.dart';

typedef VideoDetailProvider =
    NotifierProvider<
      VideoDetailNotifier,
      VideoDetailStateModel
    >;

class VideoDetailNotifier
    extends Notifier<VideoDetailStateModel> {
  final VideoService videoService =
      VideoService();
  @override
  VideoDetailStateModel build() {
    // TODO: implement build
    return VideoDetailStateModel();
  }

  void getVideo(String? id) async {
    if (id == null) {
      state = state.copyWidth(isError: true);
      return;
    }
    try {
      state = state.copyWidth(
        isLoading: true,
        isSucess: false,
        isError: false,
      );
      final VideoData result = await videoService
          .getVideoDetail(
            type: ApiConst.video,
            id: id,
          );
      state = state.copyWidth(
        videoData: result,
        isLoading: false,
        isSucess: true,
      );
    } catch (e) {
      state = state.copyWidth(
        isError: true,
        isLoading: false,
      );
    }
  }
}
