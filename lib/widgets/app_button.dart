import 'package:ayur_project/constants/app_colors.dart';
import 'package:ayur_project/constants/app_styles.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  final bool isLoaderEnabled;
  final double width;
  final double textSize;

  const AppButton({
    super.key,
    required this.text,
    required this.onTap,
    required this.isLoaderEnabled,
    this.width = double.infinity,
    this.textSize = 20
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
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: isLoaderEnabled
                  ? CircularProgressIndicator(color: AppColors.white)
                  : Text(
                    text,
                    style: AppTextStyles.poppinsMedium(textSize, color: AppColors.white,),
                  ),
        ),
      ),
    );
  }
}
