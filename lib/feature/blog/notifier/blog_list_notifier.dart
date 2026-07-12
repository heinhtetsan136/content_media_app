import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/blog_model.dart';
import '../service/blog_service.dart';
import 'blog_list_state.dart';

class BlogListNotifier
    extends Notifier<BlogListState> {
  final BlogService blogService = BlogService();
  @override
  BlogListState build() {
    return BlogListState();
  }

  void getBlogList() async {
    try {
      state = state.copyWidth(
        isLoading: true,
        isError: false,
        isSucess: false,
      );
      final BlogModel blogModel =
          await blogService.getBlogList();
      state = state.copyWidth(
        isLoading: false,
        isSucess: true,
        blogModel: blogModel,
      );
    } catch (e) {
      state = state.copyWidth(
        isError: true,
        isLoading: false,
        isSucess: false,
        isPaginateLoading: false,
      );
    }
  }
}
