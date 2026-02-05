import 'package:flutter/material.dart';
import 'package:yo_ride/core/routes/app_router.dart';
import 'package:yo_ride/core/routes/app_routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRouter().generateRoutes,
      initialRoute: AppRoutes.splashScreen,
    );
  }
}
