import 'package:e_commerce_app/common/widgets/products/favourite_icon/favourite_icon.dart';
import 'package:e_commerce_app/common/widgets/rounded_images/rounded_images.dart';
import 'package:e_commerce_app/common/widgets/texts/brand_title_with_verified_icon.dart';
import 'package:e_commerce_app/common/widgets/texts/product_price_text.dart';
import 'package:e_commerce_app/features/shop/controllers/product/product_controllers.dart';
import 'package:e_commerce_app/features/shop/models/product_model.dart';
import 'package:e_commerce_app/utils/constants/colors.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:e_commerce_app/utils/helpers/helper_functions.dart';
import 'package:e_commerce_app/utils/theme/custom_themes/shadow_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../features/shop/screens/product_details/product_detail.dart';
import '../../custom_shapes/containers/rounded_container.dart';
import '../../texts/product_title_text.dart';
import 'add_to_cart_button.dart';

class ProductCardVertical extends StatelessWidget {
  final ProductModel product;

  const ProductCardVertical({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;
    final salePercentage =
        controller.calculateSalePercentage(product.price, product.salePrice);
    final dark = HelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: () => Get.to(() => ProductDetail(
            product: product,
          )),
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [ShadowStyle.verticalProductShadow],
          borderRadius: BorderRadius.circular(AppSizes.productImageRadius),
          color: dark ? AppColors.black : AppColors.white,
        ),
        child: Column(
          children: [
            // Thumbnail, Wishlist Button, Discount Tag
            RoundedContainer(
              height: 160,
              padding: const EdgeInsets.all(AppSizes.sm),
              backgroundColor: dark ? AppColors.dark : AppColors.light,
              child: Stack(
                children: [
                  // Thumbnail
                  RoundedImage(
                    imageUrl: product.thumbnail,
                    fit: BoxFit.fill,
                    applyImageRadius: true,
                    isNetworkImage: true,
                    backgroundColor: dark ? AppColors.dark : AppColors.light,
                  ),

                  //  Sale Tag
                  Positioned(
                    top: 12,
                    child: RoundedContainer(
                      radius: AppSizes.sm,
                      backgroundColor: AppColors.secondary.withOpacity(0.8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppSizes.sm, vertical: AppSizes.xs),
                      child: Text('$salePercentage%',
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .apply(color: AppColors.black)),
                    ),
                  ),
                   Positioned(
                    top: 0,
                    right: 0,
                    child: FavouriteIcon(productId:product.id,),
                  ),
                  const SizedBox(
                    height: AppSizes.spaceBtwItems / 2,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: AppSizes.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProductTitleText(
                    title: product.title,
                    maxLine: 1,
                    smallSize: true,
                  ),
                  const SizedBox(
                    height: AppSizes.spaceBtwItems / 2,
                  ),
                  BrandTitleWithVerifiedIcon(title: product.brand!.name),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Price
                      Flexible(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: AppSizes.sm),
                              child: ProductPriceText(
                                price: controller.getProductPrice(product),
                                maxLines: 1,
                                isLarge: true,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ProductCardAddToCartButton(product: product,),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
