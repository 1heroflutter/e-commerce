import 'package:e_commerce_app/utils/constants/app_texts.dart';
import 'package:e_commerce_app/utils/constants/image_strings.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';

import 'package:flutter/material.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({
    super.key,
    required this.dark,
    required this.theme,
  });

  final bool dark;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(
          height: 150,
          image: AssetImage(
              dark ? AppImages.darkAppLogo : AppImages.lightAppLogo),
        ),
        Text(AppTexts.loginTitle,
            style: theme.textTheme.headlineMedium),
        const SizedBox(
          height: AppSizes.sm,
        ),
        Text(AppTexts.loginSubTitle,
            style: theme.textTheme.bodyMedium),
      ],
    );
  }
}