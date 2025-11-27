import 'package:e_commerce_app/features/shop/controllers/product/product_controllers.dart';
import 'package:e_commerce_app/features/shop/models/product_model.dart';
import 'package:e_commerce_app/utils/constants/colors.dart';
import 'package:e_commerce_app/utils/constants/image_strings.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../../../common/widgets/brand/brand_card.dart';
import '../../../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../../../common/widgets/images/circular_image.dart';
import '../../../../../common/widgets/texts/brand_title_with_verified_icon.dart';
import '../../../../../common/widgets/texts/product_price_text.dart';
import '../../../../../common/widgets/texts/product_title_text.dart';
import '../../../../../utils/constants/enums.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../all_brands/brand_products.dart';

class ProductMetaData extends StatelessWidget {
  final ProductModel product;

  const ProductMetaData({
    super.key, required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;
    final salePercent = controller.calculateSalePercentage(
        product.price, product.salePrice);
    final darkMode = HelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            RoundedContainer(
              radius: AppSizes.sm,
              backgroundColor: AppColors.secondary.withOpacity(0.8),
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.sm, vertical: AppSizes.xs),
              child: Text('$salePercent%', style: Theme
                  .of(context)
                  .textTheme
                  .labelLarge!
                  .apply(color: AppColors.black)),
            ),
            const SizedBox(width: AppSizes.spaceBtwItems),
            if(product.productType == ProductType.single.toString() &&
                product.salePrice > 0)
              Text('\$ ${product.price}', style: Theme
                  .of(context)
                  .textTheme
                  .titleSmall!
                  .apply(decoration: TextDecoration.lineThrough)),
            const SizedBox(width: AppSizes.spaceBtwItems),
            ProductPriceText(price: controller.getProductPrice(product),
              isLarge: true,
              maxLines: 1,),
          ],
        ),
        const SizedBox(height: AppSizes.spaceBtwItems / 1.5),

        ProductTitleText(title: product.title),
        const SizedBox(height: AppSizes.spaceBtwItems / 1.5),
        Row(
          children: [
            const ProductTitleText(title: 'Status'),
            const SizedBox(width: AppSizes.spaceBtwItems),
            Text(controller.getProductStockStatus(product.stock), style: Theme
                .of(context)
                .textTheme
                .titleMedium),
          ],
        ),
        const SizedBox(height: AppSizes.spaceBtwItems / 1.5),
        if (product.brand != null)
          Row(
            children: [
              // BrandCard
              Flexible(
                child: BrandCard(
                  onTap: () => Get.to(BrandProducts(brand: product.brand!)),
                  showBorder: true,
                  brand: product.brand!,
                ),
              ),
            ],
          ),
      ],
    );
  }
}