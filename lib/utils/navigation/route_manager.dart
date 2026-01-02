import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:goverment_online/features/onboarding_screen/view/onbording_screen.dart';
import '../../features/home/view/home_screen.dart';
import '../../features/login/view/login_screen.dart';
import '../../features/login/view/signup_screen.dart';
import '../../features/grievance_screen/view/grievance_Screen.dart';
import '../../features/main_screen/main_screen.dart';
import '../../features/splash/view/splash_screen.dart';
import '../constants/local_storage_key_strings.dart';
import 'app_routes.dart';

class AppRouter {
  // Define routes
  static final GoRouter router = GoRouter(
    navigatorKey: LocalStorageKeyStrings.appNavKey,
    initialLocation: AppRoutes.splash,
  

    routes: [
      GoRoute(
        path: AppRoutes.splash,
        pageBuilder: (context, state) =>
            hcCustomTransitionPage(const SplashScreen()),
      ),
      GoRoute(
        path: AppRoutes.onbordingScreen,
        pageBuilder: (context, state) =>
            hcCustomTransitionPage( OnboardingScreen()),
      ),
     
       GoRoute(
        path: AppRoutes.home,
        pageBuilder: (context, state) =>
            hcCustomTransitionPage(const HomeScreen()),
      ),
      GoRoute(
        path: AppRoutes.grievanceScreen,
        pageBuilder: (context, state) =>
            hcCustomTransitionPage(const GrievanceScreen()),
      ),
      GoRoute(
        path: AppRoutes.mainScreen,
        pageBuilder: (context, state) => hcCustomTransitionPage(MainScreen()),
      ),
        GoRoute(
        path: AppRoutes.loginScreen,
        pageBuilder: (context, state) =>
            hcCustomTransitionPage( LoginScreen()),
      ),
         GoRoute(
        path: AppRoutes.signupscreen,
        pageBuilder: (context, state) =>
            hcCustomTransitionPage( SignUpScreen()),
      ),
     
 
    ],
  );
}

CustomTransitionPage<dynamic> hcCustomTransitionPage(Widget widget) {
  return CustomTransitionPage(
    child: widget,
    transitionDuration: const Duration(milliseconds: 300),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(opacity: animation, child: child);
    },
  );
}
