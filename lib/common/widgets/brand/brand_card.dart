import 'package:e_commerce_app/features/shop/models/brand_model.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/enums.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../custom_shapes/containers/rounded_container.dart';
import '../images/circular_image.dart';
import '../texts/brand_title_with_verified_icon.dart';


class BrandCard extends StatelessWidget {
  final bool showBorder;
  final VoidCallback onTap;
  final BrandModel brand;
  const BrandCard({
    super.key, required this.showBorder, required this.onTap, required this.brand,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: RoundedContainer(
        padding: const EdgeInsets.all(AppSizes.sm),
        showBorder: showBorder,
        backgroundColor: Colors.transparent,
        child: Row(
          children: [
            // --- Icon ---
            Flexible(
              child: CircularImage(
                isNetworkImage: true,
                image:brand.image,
                fit: BoxFit.fill,
                padding: AppSizes.xs,
              ),
            ),
            const SizedBox(width: AppSizes.spaceBtwItems / 2),

            // --- Texts ---
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   BrandTitleWithVerifiedIcon(
                      title: brand.name,
                      brandTextSize: TextSizes.large),
                  Text(
                    '${brand.productsCount??0} products',
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}