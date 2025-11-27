
import 'package:e_commerce_app/features/shop/models/cart_item_model.dart';
import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../rounded_images/rounded_images.dart';
import '../../texts/brand_title_with_verified_icon.dart';
import '../../texts/product_title_text.dart';

class CartItem extends StatelessWidget {
  final CartItemModel cartItem;
  const CartItem({
    super.key, required this.cartItem,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RoundedImage(
          imageUrl: cartItem.image??"",
          width: 60,
          height: 60,
          isNetworkImage: true,
          padding: EdgeInsets.all(AppSizes.sm),
          backgroundColor: HelperFunctions.isDarkMode(context)
              ? AppColors.darkGrey
              : AppColors.light,
        ),
        const SizedBox(width: AppSizes.spaceBtwItems,),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               BrandTitleWithVerifiedIcon(title: cartItem.brandName??""),
               Flexible(
                  child: ProductTitleText(
                      title: cartItem.title??"", maxLine: 1)),
              Text.rich(
                TextSpan(
                  children: (cartItem.selectedVariation ?? {})
                      .entries
                      .map(
                        (e) => TextSpan(
                      children: [
                        TextSpan(text: ' ${e.key}', style: Theme.of(context).textTheme.bodySmall),
                        TextSpan(text: ' ${e.value}', style: Theme.of(context).textTheme.bodyLarge),
                      ],
                    ),
                  )
                      .toList(),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
