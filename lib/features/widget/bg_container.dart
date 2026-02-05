import 'package:flutter/material.dart';
import 'package:yo_ride/core/constants/app_colors.dart';

class BgContainer extends StatelessWidget {
  final Widget child;
  const BgContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primaryColor, AppColors.secondaryColor],
        ),
      ),
      child: child,
    );
  }
}
