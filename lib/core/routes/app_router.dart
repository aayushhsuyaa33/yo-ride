import 'package:flutter/widgets.dart';
import 'package:yo_ride/core/routes/app_routes.dart';
import 'package:yo_ride/features/view/splash/splash_screen1.dart';

class AppRouter {
  AppRouter();
  PageRouteBuilder transtionTo(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
        return page;
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final slideAnimation = Tween<Offset>(
          begin: const Offset(1.0, 0),
          end: Offset.zero,
        ).animate(CurvedAnimation(parent: animation, curve: Curves.easeInOut));
        return SlideTransition(position: slideAnimation, child: child);
      },
    );
  }

  Route generateRoutes(RouteSettings settings) {
    if (settings.name == AppRoutes.splashScreen) {
      return transtionTo(SplashScreen1());
    } else {
      return transtionTo(SplashScreen1());
    }
  }
}
