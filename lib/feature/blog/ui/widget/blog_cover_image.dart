import 'package:flutter/material.dart';
class BlogCoverImage extends StatelessWidget {
  const BlogCoverImage(this.imageUrl, {super.key});
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme=Theme.of(context).colorScheme;
    return  AspectRatio(aspectRatio:16/9,
    child:  imageUrl ==null ?   Container(
      color:colorScheme.surfaceContainerHighest ,
      child: Icon(Icons.image_outlined),
    ):Image.network(

      imageUrl!,fit: BoxFit.cover,loadingBuilder: (_,child,progress){
      if(progress==null) return child;
      return Container(
        color: colorScheme.surfaceContainerHighest,
        child: Align(
          alignment: Alignment.center,
          child: CircularProgressIndicator(),
        ),
      );
    },),
    ) ;
  }
}

