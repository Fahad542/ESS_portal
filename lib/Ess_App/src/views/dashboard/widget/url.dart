
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatelessWidget {
  final String _url = 'https://lms.premierspulse.com/'; // Replace with your desired URL

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: WebView(
        initialUrl: _url,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}






