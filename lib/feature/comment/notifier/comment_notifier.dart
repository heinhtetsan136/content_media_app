import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_content_library/feature/comment/model/add_comment_model.dart';
import 'package:media_content_library/feature/comment/notifier/comment_state_model.dart';
import 'package:media_content_library/feature/comment/service/comment_service.dart';
typedef CommentProvider=NotifierProvider<CommentNotifier,CommentStateModel>;
class CommentNotifier
    extends Notifier<CommentStateModel> {
  final CommentService _commentService =
      CommentService();
  @override
  CommentStateModel build() {
    // TODO: implement build
    return CommentStateModel();
  }

  void addComment({
    required String text,
    required String? type,
    required String? id,
  }) async {
    print("${state.isLoading} ${state.isSuccess}");
    try {
      state = state.copyWith(
        isLoading: true,
        isForm: false,
        isFailed: false,
        isSuccess: false,
        model: null,
      );
      final response = await _commentService
          .addComment(
            text: text,
            id: id,
            type: type,
          );
      print("comment is kjfklsjfkls $response");
      state = state.copyWith(
        isLoading: false,
        isSuccess: true,
        isFailed: false,
        model: response,
      );
    } catch (e) {
      print("this is error${e.toString()}");
      state = state.copyWith(
        isLoading: false,
        isFailed: true,
        isSuccess: false,
        isForm: false,
        model: null,
      );
    }
  }
}
