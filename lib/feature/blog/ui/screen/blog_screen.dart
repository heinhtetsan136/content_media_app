import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_content_library/const/responsive/responsive_layout.dart';
import 'package:media_content_library/feature/blog/data/blog_model.dart';
import 'package:media_content_library/feature/blog/ui/widget/blog_Item.dart';

import '../../notifier/blog_list_notifier.dart';
import '../../notifier/blog_list_state.dart';
import '../widget/desktop_blog_list.dart';
import '../widget/mobile_blog_list.dart';

typedef BlogListProvider =
    NotifierProvider<
      BlogListNotifier,
      BlogListState
    >;

class BlogScreen extends ConsumerStatefulWidget {
  const BlogScreen({super.key});

  @override
  ConsumerState<BlogScreen> createState() =>
      _BlogScreenState();
}

class _BlogScreenState
    extends ConsumerState<BlogScreen> {
  final BlogListProvider _blogListProvider =
      BlogListProvider(() {
        return BlogListNotifier();
      });
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((
      _,
    ) {
      ref
          .read(_blogListProvider.notifier)
          .getBlogList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final BlogListState state = ref.watch(
      _blogListProvider,
    );
    if (state.isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    if (state.isError) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text("Something went wrong"),
            SizedBox(height: 8),
            OutlinedButton(
              onPressed: () {
                ref
                    .read(_blogListProvider.notifier)
                    .getBlogList();
              },
              child: Text("Try again"),
            ),
          ],
        ),
      );
    } else {
      List<BlogData>? blogList =
          state.blogModel?.data ?? [];
      if (blogList.isEmpty) {
        return Center(
          child: Text("Empty Blog List"),
        );
      }
      return ResponsiveLayout(
        tablet: DesktopBlogList(blogList: blogList, state: state, ref: ref, blogListProvider: _blogListProvider),

        mobile: MobileBlogList(
          blogList: blogList,
          state: state,
          ref: ref,
          blogListProvider: _blogListProvider,
        ),
      );
    }
  }
}


