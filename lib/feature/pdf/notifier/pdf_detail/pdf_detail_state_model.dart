import 'package:media_content_library/feature/pdf/service/pdf_model.dart';

class PdfDetailStateModel {
  final PdfData? pdfData;
  final bool isLoading;

  final bool isError;
  final bool isSucess;

  PdfDetailStateModel({
    this.pdfData,
    this.isLoading=true,
    this.isError=false,
    this.isSucess=false,
  });
  PdfDetailStateModel copyWidth({
    PdfData? audioData,
    bool? isLoading,

    bool? isError,
    bool? isSucess,
  }) {
    return PdfDetailStateModel(
      pdfData: audioData,
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      isSucess: isSucess ?? this.isSucess,
    );
  }
}