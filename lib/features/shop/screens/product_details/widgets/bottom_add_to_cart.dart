import 'package:e_commerce_app/features/shop/controllers/product/cart_controller.dart';
import 'package:e_commerce_app/features/shop/models/product_model.dart';
import 'package:e_commerce_app/utils/constants/colors.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/widgets/icons/circular_icon.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class BottomAddToCart extends StatelessWidget {
  final ProductModel product;

  const BottomAddToCart({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    controller.updateAlreadyAddedProductCount(product);
    final dark = HelperFunctions.isDarkMode(context);
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.defaultSpace,
          vertical: AppSizes.defaultSpace / 2),
      decoration: BoxDecoration(
        color: dark ? AppColors.darkGrey : AppColors.light,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(AppSizes.cardRadiusLg),
          topRight: Radius.circular(AppSizes.cardRadiusLg),
        ),
      ),
      child: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircularIcon(
                  icon: Iconsax.minus,
                  backgroundColor: AppColors.darkGrey,
                  width: 40,
                  height: 40,
                  color: AppColors.white,
                  onPressed: () => controller.productQuantityInCart.value < 1
                      ? null
                      : controller.productQuantityInCart.value -= 1,
                ),
                const SizedBox(width: AppSizes.spaceBtwItems),
                Text(controller.productQuantityInCart.value.toString(),
                    style: Theme.of(context).textTheme.titleSmall),
                const SizedBox(width: AppSizes.spaceBtwItems),
                CircularIcon(
                  icon: Iconsax.add,
                  backgroundColor: AppColors.black,
                  width: 40,
                  height: 40,
                  color: AppColors.white,
                  onPressed: () => controller.productQuantityInCart.value += 1,
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () => controller.productQuantityInCart.value < 1
                  ? null
                  : controller.addToCart(product),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(AppSizes.md),
                backgroundColor: controller.productQuantityInCart.value < 1?AppColors.darkGrey:AppColors.black,
                side: const BorderSide(color: AppColors.black),
              ),
              child: const Text('Add to Cart'),
            ),
          ],
        ),
      ),
    );
  }
}
