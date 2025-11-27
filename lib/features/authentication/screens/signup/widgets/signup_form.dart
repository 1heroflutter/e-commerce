import 'package:e_commerce_app/features/authentication/controllers/signup/signup_controller.dart';
import 'package:e_commerce_app/features/authentication/screens/signup/widgets/policy_and_term.dart';
import 'package:e_commerce_app/utils/constants/app_texts.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:e_commerce_app/utils/helpers/helper_functions.dart';
import 'package:e_commerce_app/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class SignupForm extends StatelessWidget {
  const SignupForm({
    super.key,
    required this.theme,
    required this.dark,
  });

  final ThemeData theme;
  final bool dark;

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    final controller = Get.put(SignupController());
    return Form(
        key: controller.signupFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: controller.firstname,
                    expands: false,
                    validator: (value) =>
                        Validator.validateEmptyText("First Name", value),
                    decoration: const InputDecoration(
                        labelText: AppTexts.firstName,
                        prefixIcon: Icon(Iconsax.user)),
                  ),
                ),
                const SizedBox(
                  width: AppSizes.spaceBtwInputFields,
                ),
                Expanded(
                  child: TextFormField(
                    controller: controller.lastname,
                    expands: false,
                    validator: (value) =>
                        Validator.validateEmptyText("Last Name", value),
                    decoration: const InputDecoration(
                        labelText: AppTexts.lastName,
                        prefixIcon: Icon(Iconsax.user)),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: AppSizes.spaceBtwInputFields,
            ),
            TextFormField(
              controller: controller.username,
              expands: false,
              validator: (value) =>
                  Validator.validateEmptyText("Username", value),
              decoration: const InputDecoration(
                  labelText: AppTexts.username, prefixIcon: Icon(Iconsax.user)),
            ),
            const SizedBox(
              height: AppSizes.spaceBtwInputFields,
            ),
            TextFormField(
              controller: controller.email,
              expands: false,
              validator: (value) => Validator.validateEmail(value),
              decoration: const InputDecoration(
                labelText: AppTexts.email,
                prefixIcon: Icon(Icons.mail),
              ),
            ),
            const SizedBox(
              height: AppSizes.spaceBtwInputFields,
            ),
            TextFormField(
              controller: controller.phone,
              expands: false,
              validator: (value) => Validator.validatePhoneNumber(value),
              decoration: const InputDecoration(
                  labelText: AppTexts.phoneNo, prefixIcon: Icon(Iconsax.call)),
            ),
            const SizedBox(
              height: AppSizes.spaceBtwInputFields,
            ),
            Obx(
              () => TextFormField(
                controller: controller.password,
                expands: false,
                obscureText: controller.hidePassword.value,
                validator: (value) => Validator.validatePassword(value),
                decoration: InputDecoration(
                    labelText: AppTexts.password,
                    prefixIcon: const Icon(Iconsax.password_check),
                    suffixIcon: IconButton(
                      onPressed: () {
                        controller.hidePassword.value =
                            !controller.hidePassword.value;
                      },
                      icon: Icon(controller.hidePassword.value
                          ? Iconsax.eye_slash
                          : Iconsax.eye),
                    )),
              ),
            ),
            const SizedBox(
              height: AppSizes.spaceBtwSections,
            ),
            PolicyAndTermCheckBox(theme: theme, dark: dark),
            const SizedBox(
              height: AppSizes.spaceBtwSections,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: controller.signup, child: const Text(AppTexts.createAccount)),
            ),
          ],
        ));
  }
}
