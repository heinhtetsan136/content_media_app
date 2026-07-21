import 'package:media_content_library/feature/video/data/video_model.dart';

class VideoStateModel {
  final bool isLoading;
  final bool isSucess;
  final bool isPagniation;
  final bool isError;
  final VideoModel? model;

  VideoStateModel({
    this.isLoading = true,
    this.isPagniation = false,
    this.isSucess = false,
    this.isError = false,
    this.model,
  });
  VideoStateModel copyWith({
    bool? isLoading,
    bool? isSucess,
    bool? isError,
    bool? isPagnition,
    VideoModel? model,
  }) {
    return VideoStateModel(
      isPagniation:
          isPagnition ?? this.isPagniation,
      isLoading: isLoading ?? this.isLoading,
      isSucess: isSucess ?? this.isSucess,
      isError: isError ?? this.isError,
      model: model ?? this.model,
    );
  }
}
