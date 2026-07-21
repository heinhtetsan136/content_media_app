import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_content_library/feature/audio/data/audio_model.dart';
import 'package:media_content_library/feature/audio/notifier/audio/audio_state_model.dart';
import 'package:media_content_library/feature/audio/services/audio_service.dart';
typedef AudioProvider=NotifierProvider<AudioNotifier,AudioStateModel>;
class AudioNotifier extends Notifier<AudioStateModel>{
 final AudioService audioService=AudioService();
  @override
  AudioStateModel build() {
    // TODO: implement build
    return AudioStateModel();
  }
  int _page=1;
  void loadMore()async{

    try{
      state=state.copyWith(isPagnition: true,);
      _page=_page+1;
       AudioModel response=await audioService.getAudio(page: _page);
       response=response.copyWith(data: [...?state.model?.data,...?response.data]);
      state=state.copyWith(isPagnition: false,model: response);
    }
    catch(e){
      state=state.copyWith(isPagnition: false);
    }
  }
  void getAllAudio()async{
    _page=1;
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