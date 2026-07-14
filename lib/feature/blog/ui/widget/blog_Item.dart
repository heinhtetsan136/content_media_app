import 'package:flutter/material.dart';
import 'package:media_content_library/const/responsive/responsive_util.dart';
import 'package:media_content_library/const/router/router.dart';
import 'package:media_content_library/feature/blog/data/blog_model.dart';
import 'package:media_content_library/feature/blog/ui/widget/blog_cover_image.dart';

class BlogItem extends StatelessWidget {
  const BlogItem({
    super.key,
    required this.blogData,
  });
  final BlogData blogData;

  @override
  Widget build(BuildContext context) {
    final bool isMobile=ResponsiveUtil.isMoblie(context);
    return InkWell(
      onTap: (){
        goRoute.push("/details/${blogData.type}/${blogData.id}");
      },
      child: Card(
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
             isMobile?SizedBox(
                  height: 250,
                  child: BlogCoverImage(blogData.coverImage)):
              Expanded(child: BlogCoverImage(blogData.coverImage)),
      
              Text(
                blogData.title ?? "",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Divider(),
              Row(
                children: [
                  Expanded(
                    child: _MetaItem(
                      icon: Icon(
                        Icons.person_2_outlined,size: 14,
                      ),
                      title: blogData.author ?? "",
                    ),
                  ),
                  Expanded(
                    child: _MetaItem(
                      icon: Icon(Icons.comment,size: 14,),
                      title:
                          blogData.comments?.length
                              .toString() ??
                          "0",
                    ),
                  ),
                  Expanded(
                    child: _MetaItem(
                      title:
                          blogData.createdAt?.split(
                            "T",
                          )[0] ??
                          "",
                      icon: Icon(
                        Icons.calendar_today,size: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MetaItem extends StatelessWidget {
  const _MetaItem({
    super.key,
    required this.title,
    required this.icon,
  });
  final String title;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        icon,
        SizedBox(height: 4),
        Flexible(
          child: Text(
            textAlign: TextAlign.center,
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(
              context,
            ).textTheme.bodySmall,
          ),
        ),
      ],
    );
  }
}
