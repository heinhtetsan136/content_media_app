import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'dart:ui_web' as ui_web;
import 'package:web/web.dart'as web;
class MyWebView extends StatefulWidget {
  final String htmlString;
  const MyWebView({super.key,required this.htmlString});

  @override
  State<MyWebView> createState() => _MyWebViewState();
}

class _MyWebViewState extends State<MyWebView> {
  late String viewType;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewType="html-string-view-${DateTime.now().microsecondsSinceEpoch}";
    ui_web.platformViewRegistry.registerViewFactory(viewType, (int id){
    final  div=web.HTMLDivElement();
    div.style.height="100%";
    div.style.width="100%";
    div.style.overflow="auto%";
    div.setHTMLUnsafe(widget.htmlString.toJS);
    return div;

    });
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: HtmlElementView(
        
        viewType: viewType,),
    );
  }
}
