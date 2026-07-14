import 'package:media_content_library/feature/audio/data/audio_model.dart';

class AudioStateModel {
  final bool isLoading;
  final bool isSucess;
  final bool isError;
  final AudioModel? model;

  AudioStateModel(
      {this.isLoading=true, this.isSucess=false, this.isError=false, this.model});
  AudioStateModel copyWith({
    bool? isLoading,
    bool? isSucess,
    bool? isError,
    AudioModel? model
}){
    return AudioStateModel(
        isLoading: isLoading ?? this.isLoading,
        isSucess: isSucess ?? this.isSucess,
        isError: isError ?? this.isError,
        model: model ?? this.model
    );
  }
}