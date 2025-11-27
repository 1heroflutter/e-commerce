import 'package:e_commerce_app/data/repositories/authentication/authentication_repository.dart';
import 'package:e_commerce_app/features/authentication/controllers/signup/verify_email_controller.dart';
import 'package:e_commerce_app/utils/constants/app_texts.dart';
import 'package:e_commerce_app/utils/constants/image_strings.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/helpers/helper_functions.dart';

class VerifyEmailScreen extends StatelessWidget {
  final String? email;

  const VerifyEmailScreen({super.key, this.email});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VerifyEmailController());
    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(onPressed: () => AuthenticationRepository.instance.logout(), icon: const Icon(Icons.clear))],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppSizes.defaultSpace),
          child: Column(
            children: [
              // Image
              Image(
                image: const AssetImage(AppImages.deliveredEmailIllustration),
                width: HelperFunctions.screenWidth() * 0.6,
              ), // Image
              const SizedBox(height: AppSizes.spaceBtwSections),

// Title & SubTitle
              Text(AppTexts.confirmEmail,
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center),
              const SizedBox(height: AppSizes.spaceBtwItems),
              Text(email ?? '',
                  style: Theme.of(context).textTheme.labelLarge,
                  textAlign: TextAlign.center),
              const SizedBox(height: AppSizes.spaceBtwItems),
              Text(AppTexts.confirmEmailSubTitle,
                  style: Theme.of(context).textTheme.labelMedium,
                  textAlign: TextAlign.center),
              const SizedBox(height: AppSizes.spaceBtwSections),

              // Buttons
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () =>
                          controller.checkEmailVerificationStatus(),
                      child: const Text(AppTexts.tContinue))),
              const SizedBox(height: AppSizes.spaceBtwItems),
              SizedBox(
                  width: double.infinity,
                  child: TextButton(
                      onPressed: () {},
                      child: const Text(AppTexts.resendEmail))),
            ],
          ),
        ),
      ),
    );
  }
}
