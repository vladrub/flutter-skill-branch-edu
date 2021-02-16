import 'dart:async';

import 'package:FlutterGalleryApp/data/unsplash_repository.dart';
import 'package:FlutterGalleryApp/store/unsplash/unsplash_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LoginPage extends StatefulWidget {
  static const routeName = '/login';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  UnsplashStore _unsplashStore;

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    _unsplashStore = Provider.of<UnsplashStore>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('LogIn page')),
      body: Builder(builder: (BuildContext context) {
        return WebView(
          initialUrl: UnsplashRepository.authUrl,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
          onPageStarted: (String url) async {
            if (url.contains(
                'https://unsplash.com/oauth/authorize/native?code=')) {
              RegExp exp = RegExp("(?<==).*");
              var oneTimeCode = exp.stringMatch(url);

              await _unsplashStore.authStore.signIn(oneTimeCode);
              Navigator.pop(context, true);
            }
          },
          onPageFinished: (String url) async {
            if (url.contains(
                'https://unsplash.com/oauth/authorize/native?code=')) {
              RegExp exp = RegExp("(?<==).*");
              var oneTimeCode = exp.stringMatch(url);

              await _unsplashStore.authStore.signIn(oneTimeCode);
              Navigator.pop(context, true);
            }
          },
          gestureNavigationEnabled: true,
        );
      }),
    );
  }
}
