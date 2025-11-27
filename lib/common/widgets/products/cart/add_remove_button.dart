import 'package:e_commerce_app/utils/constants/colors.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:e_commerce_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/icons/circular_icon.dart';


class AddRemoveButton extends StatelessWidget {
  final int quantity;
  final VoidCallback? add,remove;
  const AddRemoveButton({
    super.key, required this.quantity, this.add, this.remove,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 70),
        // Add Remove Buttons
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularIcon(
              icon: Iconsax.minus,
              width: 32,
              height: 32,
              size: AppSizes.md,
              color: HelperFunctions.isDarkMode(context) ? AppColors.darkGrey : AppColors.black,
              backgroundColor: HelperFunctions.isDarkMode(context) ? AppColors.darkerGrey : AppColors.light,
              onPressed: remove,
            ), // TCircularIcon
            const SizedBox(width: AppSizes.spaceBtwItems),
            Text(quantity.toString(), style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(width: AppSizes.spaceBtwItems),
             CircularIcon(
              icon: Iconsax.add,
              width: 32,
              height: 32,
              size: AppSizes.md,
              color: AppColors.white,
              backgroundColor: AppColors.primaryColor,
              onPressed: add,
            ),
          ],
        )
      ],
    );
  }
}
