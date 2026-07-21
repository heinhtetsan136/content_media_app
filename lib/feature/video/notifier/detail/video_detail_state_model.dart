import 'package:media_content_library/feature/audio/data/audio_model.dart';
import 'package:media_content_library/feature/video/data/video_model.dart';

class VideoDetailStateModel {
  final VideoData? videoData;
  final bool isLoading;

  final bool isError;
  final bool isSucess;

  VideoDetailStateModel({
    this.videoData,
    this.isLoading=true,
    this.isError=false,
    this.isSucess=false,
  });
  VideoDetailStateModel copyWidth({
    VideoData? videoData,
    bool? isLoading,

    bool? isError,
    bool? isSucess,
  }) {
    return VideoDetailStateModel(
      videoData: videoData,
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      isSucess: isSucess ?? this.isSucess,
    );
  }
}