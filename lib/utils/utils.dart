import 'package:ayur_project/constants/app_colors.dart';
import 'package:ayur_project/constants/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Utils{

  static showInSnackBar(BuildContext context, String value, {Duration? duration}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: duration ?? Duration(seconds: 2),
        elevation: 5,
        margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.primary.withValues(alpha: 0.5),
        content: Center(
          child: Text(
            value,
            style: AppTextStyles.poppinsRegular(14, color: AppColors.white),
          ),
        ))
    );
  }

  static formatDate(String date) {
    String dateString = date.toString();
    DateTime newDate = DateTime.parse(dateString.replaceAll('T', ' '));
    String formattedDate = DateFormat('dd/MM/yyyy').format(newDate);
    return formattedDate;
  }
}