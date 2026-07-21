import 'package:media_content_library/feature/audio/data/audio_model.dart';

class AudioDetailStateModel {
  final AudioData? audioData;
  final bool isLoading;

  final bool isError;
  final bool isSucess;

  AudioDetailStateModel({
    this.audioData,
    this.isLoading=true,
    this.isError=false,
    this.isSucess=false,
  });
  AudioDetailStateModel copyWidth({
    AudioData? audioData,
    bool? isLoading,

    bool? isError,
    bool? isSucess,
  }) {
    return AudioDetailStateModel(
      audioData: audioData,
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      isSucess: isSucess ?? this.isSucess,
    );
  }
}