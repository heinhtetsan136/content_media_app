import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/blog_model.dart';
import '../../notifier/blog_list_state.dart';
import '../screen/blog_screen.dart';
import 'blog_Item.dart';

class DesktopBlogList extends StatefulWidget {
   DesktopBlogList({
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
  State<DesktopBlogList> createState() => _DesktopBlogListState();
}

class _DesktopBlogListState extends State<DesktopBlogList> {
 final ScrollController _scrollController=ScrollController();
@override
  void dispose() {
    // TODO: implement dispose
  _scrollController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Scrollbar(
            thumbVisibility: true,
            trackVisibility: true,
            controller: _scrollController,
            child: GridView.builder(
              controller: _scrollController,
              gridDelegate:
              SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 350,
                  mainAxisExtent: 350
              ),
              itemCount: widget.blogList.length+1,
              itemBuilder: (_,i){
                if(i==widget.state.blogModel?.total){
                  return Container(
                    padding: EdgeInsets.all(8),
                    alignment: Alignment.center,
                    child: Center(child: Text("No More Data")),
                  );
                }

                if(i==widget.blogList.length){

                  if(widget.state.isPaginateLoading ==false){
                    Future((){
                      widget.ref.read(widget._blogListProvider.notifier).loadMore();
                    });

                  }
                  return SizedBox(
                  );
                }
                return BlogItem(blogData: widget.blogList[i]);
              },
            ),
          ),
        ),
        widget.state.isPaginateLoading ? Container(
            padding: EdgeInsets.all(8),
            alignment: Alignment.center,
            child: CircularProgressIndicator()) : SizedBox.shrink(),
      ],
    );
  }
}