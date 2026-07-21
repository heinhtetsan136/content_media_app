import 'package:flutter/material.dart';
class BlogCoverImage extends StatelessWidget {
  const BlogCoverImage(this.imageUrl, {super.key});
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme=Theme.of(context).colorScheme;
    return  imageUrl ==null ?   Container(
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
    },
    errorBuilder: (_,_,_){
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Icon(Icons.image_not_supported,size: 80,),
        );
    },
    ) ;
  }
}

