import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../constants/app_colors.dart';
import '../constants/app_resources.dart';

class AppAppBar extends StatelessWidget implements PreferredSizeWidget{
  const AppAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const SizedBox.shrink(),
      shadowColor: AppColors.white,
      surfaceTintColor: AppColors.white,
      backgroundColor: AppColors.white,
      elevation: 0,
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: SvgPicture.asset(AppResources.bellIcon, width: 23, height: 23,),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
