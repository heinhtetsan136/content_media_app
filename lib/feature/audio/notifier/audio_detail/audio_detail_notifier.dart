import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_content_library/const/api_const/api_const.dart';
import 'package:media_content_library/feature/audio/notifier/audio_detail/audio_detail_state_model.dart';
import 'package:media_content_library/feature/audio/services/audio_service.dart';

import '../../data/audio_model.dart';
typedef AudioDetailProvider=NotifierProvider<AudioDetailNotifier,AudioDetailStateModel>;
class AudioDetailNotifier
    extends Notifier<AudioDetailStateModel> {
  final AudioService audioService =
      AudioService();
  @override
  AudioDetailStateModel build() {
    // TODO: implement build
    return AudioDetailStateModel();
  }

  void getAudio(String? id) async {
    if(id==null){
      state=state.copyWidth(isError: true);
      return;
    }
    try {

      state = state.copyWidth(
        isLoading: true,
        isSucess: false,
        isError: false,
      );
      final AudioData result = await audioService
          .getAudioDetail(
            type: ApiConst.audio,
            id: id,
          );
      state = state.copyWidth(
        audioData: result,
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
