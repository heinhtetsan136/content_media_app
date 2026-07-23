
import 'package:dio/dio.dart';
import 'package:media_content_library/feature/pdf/service/pdf_model.dart';

import '../../../const/api_const/api_const.dart';
import '../../../const/di/locator.dart';

class PdfService {
  final Dio _dio=getIt.get();
  Future<PdfModel> getPdf({int page=1,int limit=20})async{
    final response=await _dio.get("content",
        queryParameters: {
          "type": ApiConst.pdf,
          "page": page,
          "limit": limit
        }
    );
    return PdfModel.fromJson(response.data);
  }
  Future<PdfData> getPdfDetail({required String type,required String id})async{
    final response=await _dio.get("content/$type/$id");
    return PdfData.fromJson(response.data);}
}