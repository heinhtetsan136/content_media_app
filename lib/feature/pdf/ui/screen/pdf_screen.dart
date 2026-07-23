import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_content_library/feature/pdf/notifier/pdf_notifier.dart';
import 'package:media_content_library/feature/pdf/service/pdf_model.dart';

import 'package:media_content_library/feature/ui/widget/failed_widget.dart';

import '../widget/pdf_item.dart';
class PdfScreen extends ConsumerStatefulWidget {
  const PdfScreen({super.key});

  @override
  ConsumerState<PdfScreen> createState() => _PdfScreenState();
}

class _PdfScreenState extends ConsumerState<PdfScreen> {
  final PdfProvider pdfProvider=PdfProvider(()=>PdfNotifier());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      ref.read(pdfProvider.notifier).getAll();
    });
  }
  @override
  Widget build(BuildContext context) {
    final state=ref.watch(pdfProvider);
     if(state.isLoading){
      return Center(child: CircularProgressIndicator(),);
    }
     if(state.isError){
       return Center(
         child: FailedWidget(ref: ref, onTry: (){ref.read(pdfProvider.notifier).getAll();}),
       );
     }
     List<PdfData> data=state.model?.data ??[];
     return ListView.builder(itemBuilder: (_,i){
       final pdfData=data[i];
       return PdfItem(data:pdfData , colorScheme: Theme.of(context).colorScheme);
     },itemCount: data.length);
  }
}