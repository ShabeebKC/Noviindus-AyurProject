import 'package:ayur_project/constants/app_colors.dart';
import 'package:ayur_project/modules/home/screens/home_screen.dart';
import 'package:ayur_project/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../constants/app_resources.dart';
import '../../../constants/app_styles.dart';
import '../../../widgets/app_button.dart';
import '../view_models/login_view_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController username = TextEditingController(
    text: "test_user"
  );
  TextEditingController password = TextEditingController(
    text: "12345678"
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SafeArea(child: _renderBottomNavBar()),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _headerImage(context),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Login or Register To Book Your Appointments",
                      style: AppTextStyles.poppinsMedium(24)
                  ),
                  const SizedBox(height: 40),
                  ..._buildFields(username, fieldName: "Email", hint: "Enter your email"),
                  const SizedBox(height: 40),
                  ..._buildFields(password, fieldName: "Password", hint: "Enter password"),
                  const SizedBox(height: 60),
                  Consumer<LoginViewModel>(
                      builder: (context, login, child) {
                        return AppButton(text: "Login", onTap: () async {
                          await context.read<LoginViewModel>().tryLogin(username.text, password.text).then((value) {
                            if (value) {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
                            } else {
                              Utils.showInSnackBar(context, "Login Failed");
                            }
                          });
                        }, isLoaderEnabled: login.isLoading);
                      }
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _headerImage(BuildContext context){
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Image.asset(
          width: MediaQuery.of(context).size.width,
          AppResources.appBg,
          fit: BoxFit.cover,
        ),
        Center(child: SvgPicture.asset(
          AppResources.appLogo,
          width: 85,
          height: 85,)
        ),
      ],
    );
  }

  Widget _renderBottomNavBar() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
        child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                text: "By creating or logging into an account you are agreeing with our",
                style: AppTextStyles.poppinsRegular(13),
                children: [
                  TextSpan(
                    text: "Terms and Conditions",
                    style: AppTextStyles.poppinsRegular(
                        14, color: AppColors.blueText),
                  ),
                  TextSpan(
                    text: " and ",
                    style: AppTextStyles.poppinsRegular(13),
                  ),
                  TextSpan(
                    text: "Privacy Policy",
                    style: AppTextStyles.poppinsRegular(
                        14, color: AppColors.blueText),
                  ),
                ]
            )),
      ),
    );
  }

  List<Widget> _buildFields(TextEditingController controller,{required String fieldName, required String hint}){
    return [
      Text(fieldName, style: AppTextStyles.poppinsRegular(16)),
      const SizedBox(height: 8),
      TextFormField(
        autofocus: false,
        controller: controller,
        cursorColor: AppColors.primary,
        decoration: AppInputDecorationStyles.formFieldDecoration(hint, 12),
      )
    ];
  }
}
