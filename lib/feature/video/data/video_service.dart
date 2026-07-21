import 'package:dio/dio.dart';
import 'package:media_content_library/feature/video/data/video_model.dart';

import '../../../const/api_const/api_const.dart';
import '../../../const/di/locator.dart';

class VideoService {
  final Dio _dio=getIt.get();
  Future<VideoModel> getAudio({int page=1,int limit=20})async{
    final response=await _dio.get("content",
        queryParameters: {
          "type": ApiConst.video,
          "page": page,
          "limit": limit
        }
    );
    return VideoModel.fromJson(response.data);
  }


  Future<VideoData> getVideoDetail({required String type,required String id})async{
    final response=await _dio.get("content/$type/$id");
    return VideoData.fromJson(response.data);}
}