import 'package:flutter/widgets.dart';
import 'package:yo_ride/core/constants/app_colors.dart';

class TimelineIndicator extends StatelessWidget {
  const TimelineIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 12,
          width: 12,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.whiteColor,
          ),
        ),
        Container(height: 85, width: 2, color: AppColors.whiteColor),
        Container(
          height: 12,
          width: 12,
          decoration: const BoxDecoration(
            shape: BoxShape.rectangle,
            color: AppColors.whiteColor,
          ),
        ),
      ],
    );
  }
}
