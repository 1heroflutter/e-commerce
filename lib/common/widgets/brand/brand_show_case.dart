import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/common/widgets/loaders/shimmer.dart';
import 'package:e_commerce_app/features/shop/models/brand_model.dart';
import 'package:e_commerce_app/features/shop/screens/all_brands/brand_products.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../custom_shapes/containers/rounded_container.dart';
import 'brand_card.dart';

class BrandShowcase extends StatelessWidget {
  final List<String> image;
  final BrandModel brand;

  const BrandShowcase({
    super.key,
    required this.brand,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(() => BrandProducts(brand: brand)),
      child: RoundedContainer(
        showBorder: true,
        borderColor: AppColors.darkGrey,
        backgroundColor: Colors.transparent,
        padding: const EdgeInsets.all(AppSizes.md),
        margin: const EdgeInsets.only(bottom: AppSizes.spaceBtwItems),
        child: Column(
          children: [
            BrandCard(
              showBorder: false,
              onTap: () {},
              brand: brand,
            ),
            const SizedBox(height: AppSizes.spaceBtwItems),
            Row(
                children: image
                    .map(
                      (image) => brandTopProductImageWidget(image, context),
                    )
                    .toList()),
          ],
        ),
      ),
    );
  }
}

Widget brandTopProductImageWidget(String image, context) {
  return Expanded(
    child: RoundedContainer(
        height: 100,
        padding: const EdgeInsets.all(AppSizes.md),
        margin: const EdgeInsets.only(right: AppSizes.sm),
        backgroundColor: HelperFunctions.isDarkMode(context)
            ? AppColors.darkerGrey
            : AppColors.light,
        child: CachedNetworkImage(
          fit: BoxFit.contain,
          imageUrl: image,
          progressIndicatorBuilder: (context, url, progress) =>
              const ShimmerEffect(width: 100, height: 100),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        )),
  );
}
