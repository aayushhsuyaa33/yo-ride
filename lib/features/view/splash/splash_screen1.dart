import 'package:flutter/material.dart';
import 'package:yo_ride/features/widget/bg_container.dart';
import 'package:yo_ride/features/widget/splash/logo_card.dart';

class SplashScreen1 extends StatefulWidget {
  const SplashScreen1({super.key});

  @override
  State<SplashScreen1> createState() => _SplashScreen1State();
}

class _SplashScreen1State extends State<SplashScreen1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BgContainer(
        child: SafeArea(child: Center(child: LogoCardSplash())),
      ),
    );
  }
}
