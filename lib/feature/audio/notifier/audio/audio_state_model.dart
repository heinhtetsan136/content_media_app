import 'package:media_content_library/feature/audio/data/audio_model.dart';

class AudioStateModel {
  final bool isLoading;
  final bool isSucess;
  final bool isPagniation;
  final bool isError;
  final AudioModel? model;

  AudioStateModel(
      {this.isLoading=true, this.isPagniation=false,this.isSucess=false, this.isError=false, this.model});
  AudioStateModel copyWith({
    bool? isLoading,
    bool? isSucess,
    bool? isError,
    bool? isPagnition,
    AudioModel? model
}){
    return AudioStateModel(
      isPagniation: isPagnition??this.isPagniation,
        isLoading: isLoading ?? this.isLoading,
        isSucess: isSucess ?? this.isSucess,
        isError: isError ?? this.isError,
        model: model ?? this.model
    );
  }
}