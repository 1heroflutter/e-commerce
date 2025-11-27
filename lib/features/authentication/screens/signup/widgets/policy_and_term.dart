import 'package:e_commerce_app/features/authentication/controllers/signup/signup_controller.dart';
import 'package:e_commerce_app/utils/constants/app_texts.dart';
import 'package:e_commerce_app/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PolicyAndTermCheckBox extends StatelessWidget {
  const PolicyAndTermCheckBox({
    super.key,
    required this.theme,
    required this.dark,
  });

  final ThemeData theme;
  final bool dark;

  @override
  Widget build(BuildContext context) {
    final controller = SignupController.instance;
    return Row(
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: Obx(
                () => Checkbox(
              value: controller.privacyPolicy.value,
              onChanged: (value) => controller.privacyPolicy.value = value!,
            ),
          )

        ),
        Text.rich(TextSpan(children: [
          TextSpan(
              text: "${AppTexts.iAgreeTo} ", style: theme.textTheme.bodySmall),
          TextSpan(
              text: AppTexts.privacyPolicy,
              style: theme.textTheme.bodySmall!.apply(
                  color: dark ? AppColors.white : AppColors.primaryColor,
                  decoration: TextDecoration.underline,
                  decorationColor:
                      dark ? AppColors.white : AppColors.primaryColor)),
          TextSpan(text: " and ", style: theme.textTheme.bodySmall),
          TextSpan(
              text: AppTexts.termsOfUse,
              style: theme.textTheme.bodySmall!.apply(
                  color: dark ? AppColors.white : AppColors.primaryColor,
                  decoration: TextDecoration.underline,
                  decorationColor:
                      dark ? AppColors.white : AppColors.primaryColor)),
        ]))
      ],
    );
  }
}
