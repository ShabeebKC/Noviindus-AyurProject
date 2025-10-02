import 'dart:async';
import 'package:ayur_project/constants/app_configs.dart';
import 'package:ayur_project/constants/app_resources.dart';
import 'package:ayur_project/constants/string_constants.dart';
import 'package:ayur_project/screens/register_screen.dart';
import 'package:ayur_project/utils/shared_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../constants/app_colors.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => _initSplash(context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.transparent,
      body: Stack(
        children: [
          Image.asset(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            AppResources.appBg,
            fit: BoxFit.cover,
          ),
          Center(child: SvgPicture.asset(AppResources.appLogo)),
        ],
      ),
    );
  }

  Future<void> _initSplash(BuildContext context) async {
    AppConfigs.appToken = await SharedUtils.getString(StringConstants.appToken);
    Timer(const Duration(seconds: 3), () {
      if(AppConfigs.appToken.isEmpty) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const RegisterScreen()),
        );
      }
    });
  }
}
