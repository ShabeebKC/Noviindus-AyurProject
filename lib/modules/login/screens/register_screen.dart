import 'package:ayur_project/constants/app_styles.dart';
import 'package:flutter/material.dart';
import '../../../constants/app_colors.dart';
import '../../../widgets/app_app_bar.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: Text("Register", style: AppTextStyles.poppinsMedium(25)),
          ),
          Divider(height: 25),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ..._buildFields(fieldName: "Name", hint: "Enter your full name"),
                  ..._buildFields(fieldName: "Whatsapp Number", hint: "Enter your Whatsapp number"),
                  ..._buildFields(fieldName: "Address", hint: "Enter your full address"),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  List<Widget> _buildFields({required String fieldName, required String hint}){
    return [
      const SizedBox(height: 20,),
      Text(fieldName, style: AppTextStyles.poppinsRegular(16)),
      const SizedBox(height: 8),
      TextFormField(
        autofocus: false,
        cursorColor: AppColors.primary,
        decoration: AppInputDecorationStyles.formFieldDecoration(hint, 12),
      )
    ];
  }
}
