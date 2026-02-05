import 'package:flutter/material.dart';
import 'package:yo_ride/core/constants/app_colors.dart';
import 'package:yo_ride/core/theme/style.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final IconData prefixIcon;
  final VoidCallback? onMapTap;
  final TextEditingController controller;

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    this.onMapTap,
    required this.controller,
  });

  @override
  CustomTextFieldState createState() => CustomTextFieldState();
}

class CustomTextFieldState extends State<CustomTextField> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      focusNode: _focusNode,
      cursorColor: AppColors.primaryColor,
      style: const TextStyle(color: Colors.white),
      onTap: () {
        _focusNode.requestFocus();
      },

      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.darkBlackColor,
        hintText: widget.hintText,
        hintStyle: const TextStyle(color: Colors.grey),
        prefixIcon: Icon(widget.prefixIcon, color: AppColors.whiteColor),

        suffix: Padding(
          padding: EdgeInsets.symmetric(horizontal: 7),
          child: _focusNode.hasFocus
              ? GestureDetector(
                  onTap: widget.onMapTap ?? () {},
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: AppColors.whiteColor.withAlpha(150),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 12,
                      ),
                      child: Text("Map", style: w6f10p()),
                    ),
                  ),
                )
              : SizedBox(),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 10),
      ),
    );
  }
}
