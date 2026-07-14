import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:media_content_library/const/router/router.dart';

import '../api_const/api_const.dart';

GetIt getIt = GetIt.instance;
Future<void> setUpLocator()async{
 GoRouter.optionURLReflectsImperativeAPIs=true;
  final Dio dio = Dio();
 dio.options.baseUrl=ApiConst.baseUrl;
 getIt.registerSingleton<Dio>(dio);
}