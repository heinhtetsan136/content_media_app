import 'package:media_content_library/feature/pdf/service/pdf_model.dart';

class PdfStateModel {
  final bool isLoading;
  final bool isSucess;
  final bool isPagniation;
  final bool isError;
  final PdfModel? model;

  PdfStateModel(
      {this.isLoading=true, this.isPagniation=false,this.isSucess=false, this.isError=false, this.model});
  PdfStateModel copyWith({
    bool? isLoading,
    bool? isSucess,
    bool? isError,
    bool? isPagnition,
    PdfModel? model
  }){
    return PdfStateModel(
        isPagniation: isPagnition??this.isPagniation,
        isLoading: isLoading ?? this.isLoading,
        isSucess: isSucess ?? this.isSucess,
        isError: isError ?? this.isError,
        model: model ?? this.model
    );
  }
}