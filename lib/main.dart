import 'package:FlutterGalleryApp/app_router.dart';
import 'package:FlutterGalleryApp/data/unsplash_repository.dart';
import 'package:FlutterGalleryApp/res/res.dart';
import 'package:FlutterGalleryApp/store/unsplash/unsplash_store.dart';
import 'package:flutter/material.dart';
import 'package:FlutterGalleryApp/store/connectivity_store.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String token = await FlutterSecureStorage().read(key: 'token');
  AppRouter.setupRouter();
  runApp(MyApp(token));
}

class MyApp extends StatelessWidget {
  MyApp(this.token);

  final String token;
  final ConnectivityStore _connectivityStore = ConnectivityStore();
  final UnsplashStore _unsplashStore = UnsplashStore(UnsplashRepository());

  @override
  Widget build(BuildContext context) {
    _unsplashStore.repository.setAuthToken(token);

    return MultiProvider(
      providers: [
        Provider<ConnectivityStore>(create: (_) => _connectivityStore),
        Provider<UnsplashStore>(create: (_) => _unsplashStore),
      ],
      child: MaterialApp(
        title: 'Skill-branch course work',
        debugShowCheckedModeBanner: false,
        theme: buildThemeData(),
        onGenerateRoute: AppRouter.router.generator,
      ),
    );
  }
}

class ConnectivityOverlay {
  static final ConnectivityOverlay _singleton = ConnectivityOverlay._internal();

  factory ConnectivityOverlay() {
    return _singleton;
  }

  ConnectivityOverlay._internal();

  static OverlayEntry overlayEntry;

  void showOverlay(BuildContext context) {
    OverlayState overlayState = Overlay.of(context);
    overlayEntry = OverlayEntry(builder: (BuildContext context) {
      return Material(
        color: Colors.white,
        child: Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                AppIcons.connection,
                size: 59,
                color: Color(0xff919BA8),
              ),
              SizedBox(height: 21),
              Container(
                width: 171,
                child: Text(
                  'There was an error loading the feed',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline2.copyWith(
                        color: Color(0xff919BA8),
                      ),
                ),
              ),
            ],
          ),
        ),
      );
    });
    overlayState.insert(overlayEntry);
  }

  void removeOverlay(BuildContext context) {
    if (overlayEntry != null) {
      overlayEntry.remove();
      overlayEntry = null;
    }
  }
}
