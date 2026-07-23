import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_content_library/feature/pdf/notifier/pdf_state_model.dart';
import 'package:media_content_library/feature/pdf/service/pdf_model.dart';
import 'package:media_content_library/feature/pdf/service/pdf_service.dart';
typedef PdfProvider=NotifierProvider<PdfNotifier,PdfStateModel>;
class PdfNotifier
    extends Notifier<PdfStateModel> {
  final PdfService pdfService = PdfService();
  @override
  PdfStateModel build() {
    // TODO: implement build
    return PdfStateModel();
  }

  int _page = 1;
  void loadMore() async {
    try {
      state = state.copyWith(isPagnition: true);
      _page = _page + 1;
      PdfModel response = await pdfService.getPdf(
        page: _page,
      );
      response = response.copyWith(
        data: [
          ...?state.model?.data,
          ...?response.data,
        ],
      );
      state = state.copyWith(
        isPagnition: false,
        model: response,
      );
    } catch (e) {
      state = state.copyWith(isPagnition: false);
    }
  }

  void getAll() async {
    try {
      state = state.copyWith(
        isLoading: true,
        isSucess: false,
      );
      final response = await pdfService.getPdf();
      state = state.copyWith(
        isLoading: false,
        isSucess: true,
        model: response,
      );
    } catch (e) {
      state = state.copyWith(
        isSucess: false,
        isError: true,
        isLoading: false,
      );
    }
  }
}
