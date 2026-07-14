import 'package:media_content_library/feature/blog/data/blog_model.dart';

class BlogDetailStateModel {
  final BlogData? blogData;
  final bool isLoading;

  final bool isError;
  final bool isSucess;

  BlogDetailStateModel({
    this.blogData,
     this.isLoading=true,
    this.isError=false,
     this.isSucess=false,
  });
  BlogDetailStateModel copyWidth({
    BlogData? blogData,
    bool? isLoading,

    bool? isError,
    bool? isSucess,
  }) {
    return BlogDetailStateModel(
      blogData: blogData,
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      isSucess: isSucess ?? this.isSucess,
    );
  }
}
