import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yo_ride/core/constants/app_colors.dart';

class LogoCardSplash extends StatelessWidget {
  final String? text;
  const LogoCardSplash({super.key, this.text});

  Future<void> loginApi() async {
    final Dio dio = Dio();
    try {
      final response = dio.post(
        "asdasdas",
        data: {"name": "name", "password": "password"},
        options: Options(headers: {"content-Type": "Application/json"}),
      );
    } catch (exe) {
      throw Exception(exe);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.primaryColor,
      ),
      child: Text("Uber", style: GoogleFonts.openSans(fontSize: 25.sp)),
    );
  }
}
