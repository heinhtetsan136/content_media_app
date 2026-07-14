import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_content_library/feature/blog/notifier/blog_detail/blog_detail_state_model.dart';
import 'package:media_content_library/feature/blog/service/blog_service.dart';
typedef  BlogDetailProvider=NotifierProvider<BlogDetailNotifier,BlogDetailStateModel>;
class BlogDetailNotifier extends Notifier<BlogDetailStateModel>{
  final BlogService blogService=BlogService();
  @override
  BlogDetailStateModel build() {
    // TODO: implement build
    return BlogDetailStateModel();
  }
  void getBlogDetail({required String? type,required String? id})async{

   try{
    state= state.copyWidth(isLoading: true,isSucess: false);
     if(type==null || id==null){
       state=state.copyWidth(isLoading: false,isError: true,);
     }
     else{
       final response=await blogService.getBlogDetail(type: type, id: id);
       state=state.copyWidth(isLoading: false,blogData: response,isSucess: true);

     }
   }
   catch(e){
     state=state.copyWidth(isError: true,isLoading: false,isSucess: false);
   }
  }
}