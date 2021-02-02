import 'dart:async';

import 'package:FlutterGalleryApp/data/unsplash_constants.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('WebView')),
      body: Builder(builder: (BuildContext context) {
        return WebView(
          initialUrl: UnsplashConstants.authUrl,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
          // javascriptChannels: <JavascriptChannel>[
          //   _toasterJavascriptChannel(context),
          // ].toSet(),
          onPageStarted: (String url) async {
            if (url.contains(
                'https://unsplash.com/oauth/authorize/native?code=')) {
              Navigator.pop(context, url);
            }
          },
          onPageFinished: (String url) {
            if (url.contains(
                'https://unsplash.com/oauth/authorize/native?code=')) {
              Navigator.pop(context, url);
            }
          },
          gestureNavigationEnabled: true,
        );
      }),
    );
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
      name: 'Print',
      onMessageReceived: (JavascriptMessage message) {
        // print(message);
      },
    );
  }
}
