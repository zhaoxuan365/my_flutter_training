import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HtmlWebViewDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Webview'),
      ),
      body: WebView(
        initialUrl: 'file:///android_asset/flutter_assets/assets/news.html',
      ),
    );
  }
}
