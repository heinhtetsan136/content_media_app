import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:media_content_library/feature/comment/data/comment_model.dart';
import 'package:media_content_library/feature/comment/model/add_comment_model.dart';
import 'package:media_content_library/feature/comment/notifier/comment_notifier.dart';

import '../../const/storage/user_session.dart';

void showCommentDialog({
  required WidgetRef ref,
  required BuildContext context,
  required String? type,
  required String? id,
  required String? title,
  required List<CommentModel>? comments,
}) {
  showDialog(
    context: context,
    builder: (_) {
      return ShowCommentDialog(
        comments: comments,
        title: title,
        type: type,
        id: id,
      );
    },
  );
}

class ShowCommentDialog
    extends ConsumerStatefulWidget {
  final String? id, type, title;
  final List<CommentModel>? comments;
  const ShowCommentDialog({
    super.key,
    required this.comments,
    required this.type,
    required this.id,
    required this.title,
  });

  @override
  ConsumerState<ShowCommentDialog>
  createState() => _ShowCommentDialogState();
}

class _ShowCommentDialogState
    extends ConsumerState<ShowCommentDialog> {
  final UserSession _userSession = UserSession();
  final TextEditingController controller =
      TextEditingController();
  final CommentProvider commentProvider =
      CommentProvider(() => CommentNotifier());
  List<CommentModel> _comments = [];
  bool _isLoggedIn = false;
  @override
  void initState() {
    super.initState();
    _comments = widget.comments ?? [];
    _userSession.getToken().then((token) {
      setState(() {
        _isLoggedIn = token?.isNotEmpty == true;
      });
    });
  }
  @override
  Widget build(BuildContext context) {

    final stateModel = ref.watch(commentProvider);
    print(stateModel.isLoading);
    _comments = widget.comments ?? [];
    ref.listen(commentProvider, (oldState, newState) {
      if (oldState?.isLoading == true && newState.isFailed) {
        print("${newState.model} this is failed");
        controller.clear();
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Error"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [Text("Comment Error"), SizedBox(height: 8)],
              ),
              actions: [
                FilledButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("OK"),
                ),
              ],
            );
          },
        );
      }
      if (oldState?.isLoading == true &&
          newState.isSuccess &&
          newState.model != null) {
        AddCommentModel model = newState.model!;
        setState(() {
          controller.clear();
          _comments.add(
            CommentModel(
              id: model.id,
              user: model.user,
              userId: model.userId,
              createdAt: model.createdAt,
              text: model.text,
            ),
          );
        });
      }
    });
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 300,
            width: 500,
            child: ListView.builder(
              itemBuilder: (_, i) {
                final comment =
                    _comments[i];
                return ListTile(
                  leading: Icon(Icons.person),
                  title: Text(comment.user ?? ""),
                  subtitle: Text(
                    comment.text ?? "",
                  ),
                );
              },
              itemCount:
                  _comments.length ?? 0,
            ),
          ),
       if(_isLoggedIn)   TextField(
            controller: controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              suffix: stateModel.isLoading
                  ? CircularProgressIndicator()
                  : IconButton(
                      onPressed: () async {
                        if (controller
                            .text
                            .isEmpty) {

                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Please Enter Comments",
                              ),
                            ),
                          );
                          return;
                        } else {
                          ref
                              .read(
                                commentProvider
                                    .notifier,
                              )
                              .addComment(
                                text: controller
                                    .text,
                                type: widget.type,
                                id: widget.id,
                              );
                        }
                      },
                      icon: Icon(Icons.send),
                    ),
            ),
          ),
          if (!_isLoggedIn)
            Align(
              alignment: Alignment.center,
              child: FilledButton(
                onPressed: () {
                  context.push("/login");
                },
                child: Text("Login"),
              ),
            ),
        ],
      ),
      title: Text(widget.title ?? "...."),
    );
    ;
  }
}
