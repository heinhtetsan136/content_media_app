import 'package:dio/dio.dart';
import 'package:media_content_library/const/api_const/api_const.dart';
import 'package:media_content_library/feature/audio/data/audio_model.dart';

import '../../../const/di/locator.dart';

class AudioService {
  final Dio _dio=getIt.get();
  Future<AudioModel> getAudio({int page=1,int limit=20})async{
    final response=await _dio.get("content",
queryParameters: {
  "type": ApiConst.audio,
  "page": page,
  "limit": limit
}
    );
return AudioModel.fromJson(response.data);
  }
}