
import 'package:e_commerce_app/features/authentication/controllers/login/login_controller.dart';
import 'package:e_commerce_app/utils/constants/colors.dart';
import 'package:e_commerce_app/utils/constants/image_strings.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class SocialButton extends StatelessWidget {
  const SocialButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = LoginController();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.grey),
            borderRadius: BorderRadius.circular(100),),
          child: IconButton(onPressed:() => controller.googleSignIn(),
              icon: const Image(width: AppSizes.iconMd,
                  height: AppSizes.iconMd,
                  image: AssetImage(AppImages.google))),
        ),
        const SizedBox(width: AppSizes.spaceBtwItems,),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.grey),
            borderRadius: BorderRadius.circular(100),),
          child: IconButton(onPressed: () {

          },
              icon: const Image(width: AppSizes.iconMd,
                  height: AppSizes.iconMd,
                  image: AssetImage(AppImages.facebook))),
        )
      ],
    );
  }
}


