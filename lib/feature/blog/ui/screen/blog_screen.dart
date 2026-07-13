import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_content_library/feature/blog/data/blog_model.dart';
import 'package:media_content_library/feature/blog/ui/widget/blog_Item.dart';

import '../../notifier/blog_list_notifier.dart';
import '../../notifier/blog_list_state.dart';

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
        itemCount: blogList.length+1,
        itemBuilder: ((_, i) {
          if(i==blogList.length){
            if(i==state.blogModel?.total){
              return Center(
                child: Text("No more data"),
              );
            }
            if(state.isPaginateLoading ==false){
              Future((){
                ref.read(_blogListProvider.notifier).loadMore();
              });
            }
            return Container(
                padding: EdgeInsets.all(8),
                alignment: Alignment.center,
                child: CircularProgressIndicator());
          }
          BlogData blogData = blogList[i];
          String? coverImage =
              blogData.coverImage;
          String? comment="${blogData.comments?.length} comments";
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: BlogItem(blogData: blogData)
          );
        }),
      );
    }
  }
}
