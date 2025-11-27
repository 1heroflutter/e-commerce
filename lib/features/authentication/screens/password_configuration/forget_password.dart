import 'package:e_commerce_app/features/authentication/controllers/forget_password/forget_password_controller.dart';
import 'package:e_commerce_app/utils/constants/app_texts.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:e_commerce_app/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';


class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final email = TextEditingController();
    final controller = ForgetPasswordController();
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Headings
            Text(AppTexts.forgetPasswordTitle, style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: AppSizes.spaceBtwItems),
            Text(AppTexts.forgetPasswordSubTitle, style: Theme.of(context).textTheme.labelMedium),
            const SizedBox(height: AppSizes.spaceBtwSections * 2),

            // Text field
            Form(
              key: controller.forgetPasswordFormKey,
              child: TextFormField(
                controller: email,
                validator:(value) =>  Validator.validateEmail(value),
                decoration: const InputDecoration(
                  labelText: AppTexts.email,
                  prefixIcon: Icon(Iconsax.direct_right),
                ),
              ),
            ),
            const SizedBox(height: AppSizes.spaceBtwSections),

            // Submit Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed:() => controller.sendPasswordResetEmail(email.text.trim()),
                child: const Text(AppTexts.submit),
              ),
            ),
          ],
        ),
      ),
    );
  }
}