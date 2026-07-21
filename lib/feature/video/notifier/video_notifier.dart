import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_content_library/feature/video/data/video_model.dart';
import 'package:media_content_library/feature/video/data/video_service.dart';
import 'package:media_content_library/feature/video/notifier/video_state_model.dart';
typedef VideoProvider=NotifierProvider<VideoNotifier,VideoStateModel>;
class VideoNotifier
    extends Notifier<VideoStateModel> {
  final VideoService videoService =
      VideoService();
  @override
  VideoStateModel build() {
    // TODO: implement build
    return VideoStateModel();
  }

  int _page = 1;

  void loadMore() async {
    try {
      state = state.copyWith(isPagnition: true);
      _page = _page + 1;
      VideoModel response = await videoService
          .getAudio(page: _page);
      response = response.copyWith(
        data: [
          ...?state.model?.data,
          ...?response.data,
        ],
      );
      state = state.copyWith(
        isPagnition: false,
        model: response,
      );
    } catch (e) {
      state = state.copyWith(isPagnition: false);
    }
  }

  void getAll() async {
    _page = 1;
    try {
      state = state.copyWith(
        isLoading: true,
        isSucess: false,
      );
      final response = await videoService
          .getAudio();
      state = state.copyWith(
        isLoading: false,
        isSucess: true,
        model: response,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        isError: true,
        isSucess: false,
      );
    }
  }
}
