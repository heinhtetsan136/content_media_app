import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../api_const/api_const.dart';

GetIt getIt = GetIt.instance;
Future<void> setUpLocator()async{
  final Dio dio = Dio();
 dio.options.baseUrl=ApiConst.baseUrl;
 getIt.registerSingleton<Dio>(dio);
}