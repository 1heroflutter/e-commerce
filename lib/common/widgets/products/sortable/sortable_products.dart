import 'package:e_commerce_app/features/shop/controllers/product/get_all_product_controller.dart';
import 'package:e_commerce_app/features/shop/models/product_model.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../common/widgets/products/product_cards/product_card_vertical.dart';

class SortableProducts extends StatelessWidget {
  final List<ProductModel> products;

  const SortableProducts({
    super.key, required this.products,
  });

  @override
  Widget build(BuildContext context) {
    final controller = AllProductsController.instance;
    controller.assignProducts(products);
    return Column(
      children: [
        // Dropdown
        DropdownButtonFormField(
          decoration: const InputDecoration(prefixIcon: Icon(Iconsax.sort)),
          initialValue: controller.selectedSortOption.value,
          onChanged: (value) {
            controller.sortProducts(value!);
          },
          items: ['Name', 'Higher Price', 'Lower Price', 'Sale', 'Newest', 'Popularity']
              .map((option) => DropdownMenuItem(value: option, child: Text(option)))
              .toList(),
        ),
        const SizedBox(height: AppSizes.spaceBtwSections),

        // Products
        Obx(()=> GridLayout(itemCount: controller.products.length, itemBuilder: (_, index) => ProductCardVertical(product: controller.products[index]))),
      ],
    );
  }
}
