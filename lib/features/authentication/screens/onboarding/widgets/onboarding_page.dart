import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:e_commerce_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({
    super.key,
    required this.theme,
    required this.image,
    required this.title,
    required this.subTitle,
  });

  final ThemeData theme;
  final String image, title, subTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSizes.defaultSpace),
      child: Column(
        children: [
          Image(
            width: HelperFunctions.screenWidth(),
            height: HelperFunctions.screenHeight() * 0.6,
            image: AssetImage(image),
            fit: BoxFit.contain,
          ),
          Text(
            title,
            style: theme.textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: AppSizes.spaceBtwItems,
          ),
          Text(
            subTitle,
            style: theme.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
