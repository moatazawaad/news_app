import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatelessWidget {
   WebViewScreen({Key? key, required this.url}) : super(key: key);

  final String? url;
  final controller = WebViewController()
   ..setJavaScriptMode(JavaScriptMode.unrestricted)
   ..setBackgroundColor(const Color(0x00000000))
   ..setNavigationDelegate(
   NavigationDelegate(
   onProgress: (int progress) {
   // Update loading bar.
   },
   onPageStarted: (String url) {},
   onPageFinished: (String url) {},
   onWebResourceError: (WebResourceError error) {},
   onNavigationRequest: (NavigationRequest request) {
   if (request.url.startsWith('https://www.youtube.com/')) {
   return NavigationDecision.prevent;
   }
   return NavigationDecision.navigate;
   },
   ),
   )
   ..loadRequest(Uri.parse('https://flutter.dev'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: WebViewWidget(controller: controller,),
      ),
      // body: WebView(
      //   initialUrl: url,
      // ),
    );
  }
}
