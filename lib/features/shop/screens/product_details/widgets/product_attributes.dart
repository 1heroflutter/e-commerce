import 'package:e_commerce_app/features/shop/controllers/product/variation_controller.dart';
import 'package:e_commerce_app/features/shop/models/product_model.dart';
import 'package:e_commerce_app/utils/constants/colors.dart';
import 'package:e_commerce_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/chips/choice_chip.dart';
import '../../../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../../../common/widgets/headings/section_headings.dart';
import '../../../../../common/widgets/texts/product_price_text.dart';
import '../../../../../common/widgets/texts/product_title_text.dart';
import '../../../../../utils/constants/sizes.dart';

class ProductAttributes extends StatelessWidget {
  final ProductModel product;

  const ProductAttributes({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    final controller = Get.put(VariationController());
    return Column(
      children: [
        if (controller.selectedVariation.value.id.isNotEmpty)
          RoundedContainer(
            padding: const EdgeInsets.all(AppSizes.md),
            backgroundColor: dark ? AppColors.darkGrey : AppColors.grey,
            child: Column(
              children: [
                Row(
                  children: [
                    const SectionHeading(
                        title: 'Variation', showActionButton: false),
                    const SizedBox(width: AppSizes.spaceBtwItems),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const ProductTitleText(
                                title: 'Price : ', smallSize: true),
                            Text(
                              '\$${controller.getVariationPrice()}',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .apply(
                                      decoration: TextDecoration.lineThrough),
                            ),
                            const SizedBox(width: AppSizes.spaceBtwItems),
                            ProductPriceText(
                                price: "\$${controller.getVariationPrice()}"),
                          ],
                        ),
                        Row(
                          children: [
                            const ProductTitleText(
                                title: 'Stock : ', smallSize: true),
                            Text('In Stock',
                                style: Theme.of(context).textTheme.titleMedium),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                const ProductTitleText(
                  title:
                      "This is the Description of the Product and it can go up to max 4 lines.",
                  smallSize: true,
                  maxLine: 4,
                ),
              ],
            ),
          ),
        const SizedBox(
          height: AppSizes.spaceBtwItems,
        ),
        Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: product.productAttributes!
                .map(
                  (attribute) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SectionHeading(
                          title: attribute.name ?? "", showActionButton: false),
                      const SizedBox(height: AppSizes.spaceBtwItems / 2),
                      Obx(
                        () => Wrap(
                            spacing: 8,
                            children: attribute.values!.map(
                              (value) {
                                final isSelected = controller
                                        .selectedAttributes[attribute.name] ==
                                    value;
                                final available = controller
                                    .getAttributesAvailabilityInVariation(
                                        product.productVariations!,
                                        attribute.name!)
                                    .contains(value);
                                return BasicChoiceChip(
                                    label: value,
                                    selected: isSelected,
                                    onSelected: available
                                        ? (select) {
                                            if (select && available) {
                                              controller.onAttributeSelected(
                                                  product,
                                                  attribute.name ?? "",
                                                  value);
                                            }
                                          }
                                        : null);
                              },
                            ).toList()),
                      ),
                    ],
                  ),
                )
                .toList()),
      ],
    );
  }
}
