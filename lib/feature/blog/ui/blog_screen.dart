import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_content_library/feature/blog/data/blog_model.dart';

import '../notifier/blog_list_notifier.dart';
import '../notifier/blog_list_state.dart';

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
              onPressed: () {},
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
      return ListView.builder(
        itemCount: blogList.length,
        itemBuilder: ((_, i) {
          BlogData blogData = blogList[i];
          String? coverImage =
              blogData.coverImage;
          String? comment="${blogData.comments?.length} comments";
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                coverImage == null
                    ? Icon(Icons.image)
                    : Image.network(coverImage!),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(blogData.author ?? ""),

                    Text(comment ?? ""),
                  ],
                ),

              ],
            ),
          );
        }),
      );
    }
  }
}
