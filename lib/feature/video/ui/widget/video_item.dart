import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:media_content_library/feature/video/data/video_model.dart';

import '../../../../const/api_const/api_const.dart';
import '../../../blog/ui/widget/blog_cover_image.dart';

class VideoItem extends StatelessWidget {
  bool isMobile;
  VideoItem({
    super.key,
    required this.data,
    this.isMobile=true,
    required this.colorScheme,

  });

  final VideoData data;
  final ColorScheme colorScheme;


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        context.push("/details/${ApiConst.video}/${data.id}");
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(
            4,
          ),
        ),
        margin: EdgeInsets.all(4),
        padding: EdgeInsets.all(4),
        child: _checkItem(
          children: [
            BlogCoverImage(data.thumbnail),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(

                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.title ?? "",
                      maxLines: 1,
                      overflow:
                      TextOverflow.ellipsis,
                      style: Theme.of(
                        context,
                      ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 4),
                    // Text(data.source ?? "",maxLines: 1,
                    //   overflow:
                    //   TextOverflow.ellipsis,
                    //   style: Theme.of(
                    //     context,
                    //   ).textTheme.bodySmall?.copyWith(color:colorScheme.onSurfaceVariant ),),
                    SizedBox(height: 4),
                    Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: colorScheme.surfaceContainerHighest
                        ),
                        child: Text(data.source ?? "",style: TextStyle(
                            color: colorScheme.onSurfaceVariant
                        ),)),
                    SizedBox(height: 4),
                    Text(
                      data.duration ?? "00:00",
                    ),
                  ],
                ),
              ),
            ),
            Icon(
              Icons.play_circle_fill_outlined,
            ),
          ],
        ),
      ),
    );
  }
  Widget _checkItem({required List<Widget> children}){
    return  isMobile ? SizedBox(
      height: 100,
      width: 100,
      child: Row(
        children: children,
      ),
    ):SizedBox(
      height: 150,
      width: 150,
      child: Column(
        children: children,
      ),
    );
  }
}
