import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_content_library/feature/blog/notifier/blog_detail/blog_detail_notifier.dart';
import 'package:media_content_library/feature/ui/widget/web_view/web_view_common.dart';


class BlogDetailScreen
    extends ConsumerStatefulWidget {
  final String? type;
  final String? id;
  const BlogDetailScreen({
    super.key,
    required this.type,
    required this.id,
  });

  @override
  ConsumerState<BlogDetailScreen> createState() =>
      _BlogDetailScreenState();
}

class _BlogDetailScreenState
    extends ConsumerState<BlogDetailScreen> {
  final BlogDetailProvider blogDetailProvider =
      BlogDetailProvider(
        () => BlogDetailNotifier(),
      );
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((
      _,
    ) {
      ref
          .read(blogDetailProvider.notifier)
          .getBlogDetail(
            type: widget.type,
            id: widget.id,
          );
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(blogDetailProvider);
    final String title=state.blogData?.title ??"";

return Scaffold(
  appBar: AppBar(

    title: title.isNotEmpty ? Text(title):SizedBox.shrink(),
  ),
  body: _blogDetailBody(),
);

  }
  Widget _blogDetailBody(){


    final state = ref.watch(blogDetailProvider);
    final String content=state.blogData?.content ?? "";

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
                    .read(
                  blogDetailProvider.notifier,
                )
                    .getBlogDetail(
                  type: widget.type,
                  id: widget.id,
                );
              },
              child: Text("Try again"),
            ),
          ],
        ),
      );
    }
    if(state.isSucess) {
      return content.isNotEmpty ? MyWebView(
        htmlString: content,
      ) : SizedBox.shrink();
    }
    return SizedBox.shrink();
  }
}


