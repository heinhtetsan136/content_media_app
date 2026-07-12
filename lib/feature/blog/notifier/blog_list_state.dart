import 'package:media_content_library/feature/blog/data/blog_model.dart';

class BlogListState {
  final BlogModel? blogModel;
  final bool isLoading;
  final bool isPaginateLoading;
  final bool isError;
  final bool isSucess;

  BlogListState({
    this.blogModel,
     this.isLoading=true,
     this.isError=false,
     this.isPaginateLoading=false,
     this.isSucess=false,
  });
  BlogListState copyWidth({
    BlogModel? blogModel,
    bool? isLoading,
    bool? isPaginateLoading,
    bool? isError,
    bool? isSucess,
  }) {
    return BlogListState(
      blogModel: blogModel ?? this.blogModel,
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      isPaginateLoading: isPaginateLoading  ?? this.isPaginateLoading,
      isSucess: isSucess ?? this.isError,
    );
  }
}
