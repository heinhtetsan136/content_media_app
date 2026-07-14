import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/blog_model.dart';
import '../../notifier/blog_list_state.dart';
import '../screen/blog_screen.dart';
import 'blog_Item.dart';

class MobileBlogList extends StatelessWidget {
  const MobileBlogList({
    super.key,
    required this.blogList,
    required this.state,
    required this.ref,
    required this._blogListProvider,
  });

  final List<BlogData> blogList;
  final BlogListState state;
  final WidgetRef ref;
  final BlogListProvider _blogListProvider;

  @override
  Widget build(BuildContext context) {
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