import 'package:media_content_library/feature/comment/model/add_comment_model.dart';

class CommentStateModel {
  final bool isLoading;
  final bool isSuccess;
  final bool isFailed;
  final bool isForm;
  final AddCommentModel? model;

  CommentStateModel({
    this.isLoading = false,
    this.isSuccess = false,
    this.isForm = true,
    this.model,
    this.isFailed = false,
  });
  CommentStateModel copyWith({
    bool? isLoading,
    bool? isSuccess,
    bool? isForm,
    bool? isFailed,
    AddCommentModel? model,
  }) {
    return CommentStateModel(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailed: isFailed ?? this.isFailed,
      isForm: isForm ?? this.isForm,
      model: model ?? this.model,
    );
  }
}
