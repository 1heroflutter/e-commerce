import 'package:e_commerce_app/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/device/device_utils.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class OnBoardingNextButton extends StatelessWidget {
  const OnBoardingNextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    return Positioned(
        right: AppSizes.defaultSpace,
        bottom: DeviceUtils.getBottomNavigationBarHeight(),
        child: ElevatedButton(
          onPressed: () {
            OnBoardingController.instance.nextPage();
          },
          style: ElevatedButton.styleFrom(
              shape: CircleBorder(), backgroundColor: dark?AppColors.primaryColor:Colors.black),
          child: Icon(Icons.arrow_forward_ios),
        ));
  }
}