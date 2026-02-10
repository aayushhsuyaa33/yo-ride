import 'package:flutter/widgets.dart';
import 'package:yo_ride/core/routes/app_routes.dart';
import 'package:yo_ride/features/view/home/booking_screen.dart';
import 'package:yo_ride/features/view/map/map_picker_screen.dart';

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
    if (settings.name == AppRoutes.bookingScreen) {
      return transtionTo(BookingScreen());
    } else if (settings.name == AppRoutes.mapPickerScreen) {
      final args = settings.arguments as Map<String, dynamic>?;
      final double selectedLat = args?['selectedLat'] ?? 27.7172; // default
      final double selectedLng = args?['selectedLng'] ?? 85.3240; // default
      final String title = args?['title'] ?? "PickUp Address";
      final String address = args?['address'] ?? "";
      return transtionTo(
        MapPickerScreen(
          selectedLat: selectedLat,
          selectedLng: selectedLng,
          title: title,
          address: address,
        ),
      );
    } else {
      return transtionTo(BookingScreen());
    }
  }
}
