import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_content_library/feature/pdf/notifier/pdf_detail/pdf_detail_state_model.dart';
import 'package:media_content_library/feature/pdf/service/pdf_model.dart';
import 'package:media_content_library/feature/pdf/service/pdf_service.dart';

import '../../../../const/api_const/api_const.dart';
typedef PdfDetailProvider=NotifierProvider<PdfDetailNotifier,PdfDetailStateModel>;
class PdfDetailNotifier
    extends Notifier<PdfDetailStateModel> {
  final PdfService pdfService =
  PdfService();
  @override
  PdfDetailStateModel build() {
    // TODO: implement build
    return PdfDetailStateModel();
  }

  void getAudio(String? id) async {
    if(id==null){
      state=state.copyWidth(isError: true);
      return;
    }
    try {

      state = state.copyWidth(
        isLoading: true,
        isSucess: false,
        isError: false,
      );
      final PdfData result = await pdfService
          .getPdfDetail(
        type: ApiConst.pdf,
        id: id,
      );
      state = state.copyWidth(
        audioData: result,
        isLoading: false,
        isSucess: true,
      );
    } catch (e) {
      state = state.copyWidth(
        isError: true,
        isLoading: false,
      );
    }
  }
}