import 'package:e_commerce_app/common/widgets/login_signup/form_divider.dart';
import 'package:e_commerce_app/common/widgets/login_signup/social_button.dart';
import 'package:e_commerce_app/features/authentication/screens/signup/widgets/signup_form.dart';
import 'package:e_commerce_app/utils/constants/app_texts.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:e_commerce_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dark = HelperFunctions.isDarkMode(context);
    return Scaffold(
      // appBar: PreferredSize(
      //     preferredSize: Size(double.infinity, AppSizes.appBarHeight),
      //     child: SliverAppBar()),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.defaultSpace),
          child: Column(
            children: [
              const SizedBox(
                height: AppSizes.appBarHeight,
              ),
              Text(
                AppTexts.signupTitle,
                style: theme.textTheme.headlineMedium,
              ),
              const SizedBox(
                height: AppSizes.spaceBtwSections,
              ),
              SignupForm(theme: theme, dark: dark),
              const SizedBox(
                height: AppSizes.spaceBtwSections,
              ),
              FormDivider(
                dark: dark,
                theme: theme,
                dividerText: AppTexts.orSignInWith,
              ),
              const SizedBox(
                height: AppSizes.spaceBtwSections,
              ),
              const SocialButton(),
            ],
          ),
        ),
      ),
    );
  }
}
