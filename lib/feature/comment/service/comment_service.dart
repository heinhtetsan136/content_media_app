import 'package:dio/dio.dart';
import 'package:media_content_library/const/api_const/api_const.dart';
import 'package:media_content_library/const/di/locator.dart';
import 'package:media_content_library/const/storage/user_session.dart';
import 'package:media_content_library/feature/comment/model/add_comment_model.dart';

class CommentService {
  final Dio dio = getIt.get();
  final UserSession userSession = getIt.get();
  Future<AddCommentModel> addComment({
    required String text,
    required String? id,
    required String? type,
  }) async {
    final String? token = await userSession
        .getToken();
    if (token != null && id!=null && type!=null) {
      dio.options.headers={
        "Authorization":"Bearer $token"
      };
      final result = await dio.post(
        ApiConst.addCommentUrl(id, type),data: {
        "text":text

      }
      );

      return AddCommentModel.fromJson(result.data);
    } else {
      throw Exception("User Not Found");
    }
  }
}
