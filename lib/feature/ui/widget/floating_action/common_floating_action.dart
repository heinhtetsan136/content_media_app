import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../comment/common_dialog.dart';
import '../../../comment/data/comment_model.dart';

class CommonFloatingAction
    extends StatefulWidget {
  const CommonFloatingAction({
    super.key,
    required this.ref,
    required this.id,
    required this.title,
    required this.type,
    required this.comments,
  });

  final WidgetRef ref;
  final String? type;
  final String? id;
  final String? title;
  final List<CommentModel>? comments;

  @override
  State<CommonFloatingAction> createState() => _CommonFloatingActionState();
}

class _CommonFloatingActionState extends State<CommonFloatingAction> {

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showCommentDialog(
          ref: widget.ref,
          context: context,
          type: widget.type,
          id: widget.id,
          title: widget.title,
          comments: widget.comments,
        );
      },
      child: Icon(Icons.comment),
    );
  }
}