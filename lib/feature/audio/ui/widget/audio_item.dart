import 'package:flutter/material.dart';
import 'package:media_content_library/feature/audio/data/audio_model.dart';
import 'package:media_content_library/feature/blog/ui/widget/blog_cover_image.dart';

class AudioItem extends StatelessWidget {
  const AudioItem({
    super.key,
    required this.data,
    required this.colorScheme,
  });

  final AudioData data;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(
          4,
        ),
      ),
      margin: EdgeInsets.all(4),
      padding: EdgeInsets.all(4),
      child: SizedBox(
        width: 100,
        height: 100,
        child: Row(
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
                    Text(data.artist ?? "",maxLines: 1,
                      overflow:
                      TextOverflow.ellipsis,
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color:colorScheme.onSurfaceVariant ),),
                    SizedBox(height: 4),
                    Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: colorScheme.surfaceContainerHighest
                        ),
                        child: Text(data.type ?? "Audio",style: TextStyle(
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
}