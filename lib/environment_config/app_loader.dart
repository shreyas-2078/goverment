import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_storage/get_storage.dart';
import '../utils/constants/app_colors.dart';
import '../utils/dependency_locator.dart';
import '../utils/navigation/route_manager.dart';
import 'environment_config.dart';
import '../utils/localization/app_localizations.dart';
import '../utils/localization/localization_manager.dart';

@pragma('vm:entry-point')


class AppLoader {
  void loadApp(String path) async {
    await dotEnv.load(fileName: path);
    WidgetsFlutterBinding.ensureInitialized();
    await _preInit();
    runApp(const MyApp());
  }
}

Future<void> _preInit() async {
  try {
    await GetStorage.init();
    // Initialize localization
    final localizationManager = LocalizationManager();
    await localizationManager.initialize();
    // Set system UI overlay style to transparent
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: AppColors.white,
        systemNavigationBarDividerColor: AppColors.transparent,
      ),
    );
    await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    ]);

    // await Firebase.initializeApp(
    //     options: DefaultFirebaseOptions.currentPlatform);
    // FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundHandler);
    initDependencyLocator();
    // await DeepLinkHandler.initDeepLinks();
    // await DeepLinkHandler().init();
    await getIt.allReady();
  // ignore: empty_catches
  } catch (e) {
  }
}

// for remove scroll indicator
class NoThumbScrollBehavior extends ScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.stylus,
        PointerDeviceKind.trackpad,
      };
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    
  }

  @override
  void dispose() {
    // _networkService.dispose();
    super.dispose();
  }

 
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      // Add localization support
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: LocalizationManager.supportedLocales,
      locale: LocalizationManager().currentLocale,
      scrollBehavior: NoThumbScrollBehavior().copyWith(scrollbars: false),
      
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: const TextScaler.linear(1.0),
          ),
          child: Overlay(
            // key: WebToastNotificationService.overlayKey,
            initialEntries: [
              OverlayEntry(
                builder: (context) => child ?? const SizedBox.shrink(),
              ),
            ],
          ),
        );
      },
      
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.transparent),
        useMaterial3: true,
          fontFamily: 'Figtree',
        splashColor: AppColors.transparent,
        highlightColor: AppColors.transparent,
        bottomNavigationBarTheme:
            const BottomNavigationBarThemeData(elevation: 8.0),
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: AppColors.buttonBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(26.0),
            ),
          ),
        ),
        scaffoldBackgroundColor: Colors.transparent,
      ),
      routerDelegate: AppRouter.router.routerDelegate,
      routeInformationParser: AppRouter.router.routeInformationParser,
      routeInformationProvider: AppRouter.router.routeInformationProvider,
    );
  }

  // void subscribe() {
  //   _notificationService.messaging.subscribeToTopic('Admin');
  // }
}