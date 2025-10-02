import 'package:ayur_project/constants/app_colors.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  final bool isLoaderEnabled;
  final double width;
  final TextStyle textStyle;
  final Color color;

  const AppButton({
    super.key,
    required this.text,
    required this.onTap,
    required this.isLoaderEnabled,
    this.width = double.infinity,
    this.textStyle = const TextStyle(
        color: AppColors.white,
        fontSize: 20,
        fontWeight: FontWeight.w500,
        fontFamily: "PoppinsMedium"
    ),
    this.color = AppColors.primary
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: AppColors.transparent,
      highlightColor: AppColors.transparent,
      onTap: onTap,
      child: Container(
        height: 50,
        width: width,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: isLoaderEnabled
                  ? CircularProgressIndicator(color: AppColors.white)
                  : Text(
                    text,
                    style: textStyle,
                  ),
        ),
      ),
    );
  }
}
