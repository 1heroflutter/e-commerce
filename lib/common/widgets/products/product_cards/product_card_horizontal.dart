import 'package:e_commerce_app/common/widgets/products/favourite_icon/favourite_icon.dart';
import 'package:e_commerce_app/features/shop/controllers/product/product_controllers.dart';
import 'package:e_commerce_app/features/shop/models/product_model.dart';
import 'package:e_commerce_app/utils/constants/colors.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:e_commerce_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../../../common/widgets/rounded_images/rounded_images.dart';
import '../../texts/brand_title_with_verified_icon.dart';
import '../../texts/product_price_text.dart';
import '../../texts/product_title_text.dart';

class ProductCardHorizontalWidget extends StatelessWidget {
  final ProductModel product;
  const ProductCardHorizontalWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;
    final sale = controller.calculateSalePercentage(product.price, product.salePrice);

    final dark = HelperFunctions.isDarkMode(context);
    return Container(
      width: 310,
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.productImageRadius),
        color: dark ? AppColors.dark : AppColors.lightContainer,
      ),
      child: Row(
        children: [
          // Thumbnail
          RoundedContainer(
            height: 120,
            padding: const EdgeInsets.all(AppSizes.sm),
            backgroundColor: dark ? AppColors.dark : AppColors.light,
            child: Stack(
              children: [
                //Thumbnail Image
                 SizedBox(
                  height: 120,
                  width: 120,
                  child: RoundedImage(
                      imageUrl: product.thumbnail, applyImageRadius: true,isNetworkImage: true,),
                ),
                //Sale Tag
                Positioned(
                  top: 12,
                  child: RoundedContainer(
                    radius: AppSizes.sm,
                    backgroundColor: AppColors.secondary.withOpacity(0.8),
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppSizes.sm, vertical: AppSizes.xs),
                    child: Text('$sale%',
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .apply(color: AppColors.black)),
                  ),
                ),

                //Favourite Icon Button
                 Positioned(
                  top: 0,
                  right: 0,
                  child:FavouriteIcon(productId: product.id,),
                ),
              ],
            ),
          ),
          // Details
          SizedBox(
            width: 172,
            child: Padding(
              padding: EdgeInsets.only(top: AppSizes.sm, left: AppSizes.sm),
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProductTitleText(
                          title: product.title,
                          smallSize: true),
                      const SizedBox(height: AppSizes.spaceBtwItems / 2),
                      BrandTitleWithVerifiedIcon(title: product.brand?.name??""),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      // Pricing
                       Flexible(child: ProductPriceText(price: product.price.toString())),
                      Container(
                        decoration: const BoxDecoration(
                            color: AppColors.dark,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(
                                    AppSizes.productImageRadius),
                                topLeft:
                                    Radius.circular(AppSizes.cardRadiusMd))),
                        child: const SizedBox(
                          width: AppSizes.iconLg * 1.2,
                          height: AppSizes.iconLg * 1.2,
                          child: Center(
                            child: Icon(
                              Iconsax.add,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      )

                      // Add to cart
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
