
import 'package:dio/dio.dart';
import 'package:media_content_library/const/api_const/api_const.dart';
import 'package:media_content_library/feature/blog/data/blog_model.dart';

import '../../../const/di/locator.dart';
class BlogService {
  final Dio _dio=getIt.get();
  Future<BlogModel> getBlogList({int page=1,int limit=10})async{
   final response=  await _dio.get("content",
        queryParameters: {
        "type":ApiConst.blog,
          "page":page,
          "limit":limit
        }

      );
   return BlogModel.fromJson(response.data);

  }
}