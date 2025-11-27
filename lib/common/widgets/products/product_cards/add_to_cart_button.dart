import 'package:e_commerce_app/features/shop/controllers/product/cart_controller.dart';
import 'package:e_commerce_app/features/shop/models/product_model.dart';
import 'package:e_commerce_app/features/shop/screens/product_details/product_detail.dart';
import 'package:e_commerce_app/utils/constants/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';

class ProductCardAddToCartButton extends StatelessWidget {
  final ProductModel product;

  const ProductCardAddToCartButton({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    return InkWell(
      onTap: () {
        if (product.productType == ProductType.single.toString()) {
          final cartItem = controller.convertToCartItem(product, 1);
          controller.addOneToCart(cartItem);
        } else {
          Get.to(() => ProductDetail(product: product));
        }
      },
      child: Obx(() {
        final productQuantityInCart =
            controller.getProductQuantityInCart(product.id);

        return Container(
          decoration: BoxDecoration(
            color: productQuantityInCart > 0
                ? AppColors.primaryColor
                : AppColors.dark,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(AppSizes.cardRadiusMd),
              bottomRight: Radius.circular(AppSizes.productImageRadius),
            ),
          ),
          child: SizedBox(
            width: AppSizes.iconLg * 1.2,
            height: AppSizes.iconLg * 1.2,
            child: Center(
                child: productQuantityInCart > 0
                    ? Text(
                        productQuantityInCart.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .apply(color: Colors.white),
                      )
                    : Icon(Iconsax.add, color: AppColors.white)),
          ),
        );
      }),
    );
  }
}
