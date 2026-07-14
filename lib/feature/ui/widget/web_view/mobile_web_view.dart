import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MyWebView extends StatefulWidget {
  final String htmlString;
  const MyWebView({super.key, required this.htmlString});

  @override
  State<MyWebView> createState() =>
      _MyWebViewState();
}


class _MyWebViewState extends State<MyWebView> {
  WebViewController controller =
      WebViewController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.loadHtmlString(widget.htmlString);
  }
  @override
  Widget build(BuildContext context) {
    return WebViewWidget(controller: controller,);
  }
}
