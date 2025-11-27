import 'package:e_commerce_app/common/styles/spacing_style.dart';
import 'package:e_commerce_app/common/widgets/login_signup/form_divider.dart';
import 'package:e_commerce_app/features/authentication/screens/login/widgets/login_form.dart';
import 'package:e_commerce_app/features/authentication/screens/login/widgets/login_header.dart';
import 'package:e_commerce_app/common/widgets/login_signup/social_button.dart';
import 'package:e_commerce_app/utils/constants/app_texts.dart';
import 'package:e_commerce_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dark = HelperFunctions.isDarkMode(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: SpacingStyle.paddingWithAppBarHeight,
          child: Column(
            children: [
              LoginHeader(dark: dark, theme: theme),
              LoginForm(),
              FormDivider(dark: dark, theme: theme, dividerText: AppTexts.signIn,),
              SocialButton()
            ],
          ),
        ),
      ),
    );
  }
}
