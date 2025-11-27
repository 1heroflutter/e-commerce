import 'package:e_commerce_app/features/authentication/controllers/login/login_controller.dart';
import 'package:e_commerce_app/features/authentication/screens/password_configuration/forget_password.dart';
import 'package:e_commerce_app/features/authentication/screens/signup/signup.dart';
import 'package:e_commerce_app/utils/constants/app_texts.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:e_commerce_app/utils/helpers/helper_functions.dart';
import 'package:e_commerce_app/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = LoginController();
    return Form(
      key: controller.loginFormKey,
        child: Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSizes.spaceBtwSections),
      child: Column(
        children: [
          TextFormField(
            controller: controller.email,
            validator: (value) => Validator.validateEmail(value),
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.email), labelText: AppTexts.email),
          ),
          const SizedBox(
            height: AppSizes.spaceBtwInputFields,
          ),
          TextFormField(
            controller: controller.password,
            validator: (value) => Validator.validatePassword(value),
            decoration: InputDecoration(
                prefixIcon: Icon(Iconsax.password_check),
                labelText: AppTexts.password,
                suffixIcon: Icon(Iconsax.eye_slash)),
          ),
          const SizedBox(
            height: AppSizes.spaceBtwInputFields / 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Obx(
              ()=>
                     Checkbox(
                      value: controller.rememberMe.value,
                      onChanged: (value) {
                        controller.rememberMe.value=!controller.rememberMe.value;
                      },
                    ),
                  ),
                  const Text(AppTexts.rememberMe),
                ],
              ),
              TextButton(
                  onPressed: () => Get.to(() => const ForgetPasswordScreen()),
                  child: Text(
                    AppTexts.forgetPassword,
                    style: Theme.of(context).textTheme.labelMedium,
                  ))
            ],
          ),
          const SizedBox(
            height: AppSizes.spaceBtwSections,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () {
                  controller.emailAndPasswordSignIn();
                },
                child: const Text(AppTexts.signIn)),
          ),
          const SizedBox(
            height: AppSizes.spaceBtwItems,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () {
                  HelperFunctions.navigateToScreen(context, SignupScreen());
                },
                child: const Text(AppTexts.createAccount)),
          ),
          const SizedBox(
            height: AppSizes.spaceBtwItems,
          ),
        ],
      ),
    ));
  }
}
