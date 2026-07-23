import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_content_library/feature/blog/ui/widget/blog_cover_image.dart';
import 'package:media_content_library/feature/pdf/notifier/pdf_detail/pdf_detail_notifier.dart';
import 'package:media_content_library/feature/pdf/service/pdf_model.dart';
import 'package:media_content_library/feature/ui/widget/failed_widget.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:url_launcher/url_launcher.dart';

class PdfDetail extends ConsumerStatefulWidget {
  final String? id;
  const PdfDetail({super.key, required this.id});

  @override
  ConsumerState<PdfDetail> createState() =>
      _PdfDetailState();
}

class _PdfDetailState
    extends ConsumerState<PdfDetail> {
  final PdfDetailProvider pdfDetailProvider =
      PdfDetailProvider(
        () => PdfDetailNotifier(),
      );
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((
      _,
    ) {
      ref
          .read(pdfDetailProvider.notifier)
          .getAudio(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(pdfDetailProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          state.pdfData?.title ??
              "....Please Wait",
        ),
      ),
      body: _pdfDetail(),
    );
  }

  Widget _pdfDetail() {
    final state = ref.watch(pdfDetailProvider);
    if (state.isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    if (state.isError) {
      return FailedWidget(
        ref: ref,
        onTry: () {
          ref
              .read(pdfDetailProvider.notifier)
              .getAudio(widget.id);
        },
      );
    }
    PdfData? pdfData = state.pdfData;


    return pdfData?.url?.isNotEmpty == true

        ? kIsWeb
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      BlogCoverImage(pdfData?.previewImage ??""),
                      SizedBox(height: 10,),
                      ElevatedButton(
                        onPressed: () {
                          launchUrl(
                            Uri.parse(
                              pdfData?.url ?? "",
                            ),
                            mode: LaunchMode
                                .externalApplication,
                          );
                        },
                        child: Text(
                          "View/download Pdf",
                        ),
                      ),
                    ],
                  ),
                )
              : SfPdfViewer.network(
                  pdfData?.url ?? "",
                )
        : SizedBox.shrink();
  }
}
