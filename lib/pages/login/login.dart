import 'dart:async';

import 'package:FlutterGalleryApp/data/unsplash_constants.dart';
import 'package:FlutterGalleryApp/store/auth_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LoginPage extends StatefulWidget {
  static const routeName = '/login';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AuthStore _authStore;
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    _authStore = Provider.of<AuthStore>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('LogIn page')),
      body: Builder(builder: (BuildContext context) {
        return WebView(
          initialUrl: UnsplashConstants.authUrl,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
          onPageStarted: (String url) async {
            if (url.contains(
                'https://unsplash.com/oauth/authorize/native?code=')) {
              RegExp exp = RegExp("(?<==).*");
              var oneTimeCode = exp.stringMatch(url);

              await _authStore.signIn(oneTimeCode);
              Navigator.pop(context, true);
            }
          },
          onPageFinished: (String url) async {
            if (url.contains(
                'https://unsplash.com/oauth/authorize/native?code=')) {
              RegExp exp = RegExp("(?<==).*");
              var oneTimeCode = exp.stringMatch(url);

              await _authStore.signIn(oneTimeCode);
              Navigator.pop(context, true);
            }
          },
          gestureNavigationEnabled: true,
        );
      }),
    );
  }
}
