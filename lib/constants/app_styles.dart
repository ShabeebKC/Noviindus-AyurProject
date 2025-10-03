import 'dart:ui' as pw;
import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles{

  static TextStyle poppinsBold(double size, {Color color = AppColors.black}) {
    return TextStyle(
        color: color,
        fontSize: size,
        fontWeight: FontWeight.w600,
        fontFamily: "PoppinsBold"
    );
  }

  static TextStyle poppinsMedium(double size, {Color color = AppColors.black}) {
    return TextStyle(
        color: color,
        fontSize: size,
        fontWeight: FontWeight.w500,
        fontFamily: "PoppinsMedium"
    );
  }

  static TextStyle poppinsRegular(double size, {Color color = AppColors.black}) {
    return TextStyle(
        color: color,
        fontSize: size,
        fontWeight: FontWeight.w400,
        fontFamily: "PoppinsRegular"
    );
  }

  static TextStyle poppinsLight(double size, {Color color = AppColors.black}) {
    return TextStyle(
        color: color,
        fontSize: size,
        fontWeight: FontWeight.w300,
        fontFamily: "PoppinsLight"
    );
  }

}

class AppInputDecorationStyles{

  static InputDecoration formFieldDecoration(String hintText, double borderRadius){
    return InputDecoration(
        hintText: hintText,
        hintStyle: AppTextStyles.poppinsLight(16),
        border: OutlineInputBorder(
          borderSide: BorderSide(
              color: AppColors.fieldBorder
          ),
          borderRadius: BorderRadius.circular(borderRadius),
        )
    );
  }
}