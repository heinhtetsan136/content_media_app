import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_content_library/feature/audio/notifier/audio_state_model.dart';
import 'package:media_content_library/feature/audio/services/audio_service.dart';
typedef AudioProvider=NotifierProvider<AudioNotifier,AudioStateModel>;
class AudioNotifier extends Notifier<AudioStateModel>{
 final AudioService audioService=AudioService();
  @override
  AudioStateModel build() {
    // TODO: implement build
    return AudioStateModel();
  }
  void getAllAudio()async{
   try{
     state=state.copyWith(isLoading: true,isSucess: false);
     final response=await audioService.getAudio();
     state=state.copyWith(isLoading: false,isSucess: true,model:response);
   }
   catch(e){
     state=state.copyWith(isLoading: false,isError: true,isSucess: false);
   }
  }
}