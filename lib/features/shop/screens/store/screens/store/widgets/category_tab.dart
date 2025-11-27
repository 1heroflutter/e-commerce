import 'package:e_commerce_app/common/widgets/headings/section_headings.dart';
import 'package:e_commerce_app/common/widgets/layouts/grid_layout.dart';
import 'package:e_commerce_app/features/shop/controllers/category_controller.dart';
import 'package:e_commerce_app/features/shop/models/category_model.dart';
import 'package:e_commerce_app/features/shop/screens/all_products/all_products.dart';
import 'package:e_commerce_app/features/shop/screens/store/screens/store/widgets/category_brand.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../../common/widgets/loaders/vertical_product_shimmer.dart';
import '../../../../../../../common/widgets/products/product_cards/product_card_vertical.dart';
import '../../../../../../../utils/constants/sizes.dart';
import '../../../../../../../utils/helpers/cloud_helper_function.dart';

class CategoryTab extends StatelessWidget {
  final CategoryModel category;

  const CategoryTab({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    return ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Padding(
            padding: EdgeInsets.all(AppSizes.defaultSpace),
            child: Column(
              children: [
                CategoryBrands(category: category),
                const SizedBox(
                  height: AppSizes.spaceBtwItems,
                ),
                FutureBuilder(
                  future:
                      controller.getCategoryProducts(categoryId: category.id),
                  builder: (context, snapshot) {
                    // Helper Function: Handle Loader, No Record, OR ERROR Message
                    final response = CloudHelperFunctions.checkMultiRecordState(
                        snapshot: snapshot,
                        loader: const VerticalProductShimmer());
                    if (response != null) return response;

                    final products = snapshot.data!;
                    return Column(
                      children: [
                        SectionHeading(
                          title: 'You might like',
                          onPressed: () => Get.to(() => AllProductsScreen(
                                title: category.name,
                                futureMethod: () =>
                                    controller.getCategoryProducts(
                                        categoryId: category.id, limit: -1),
                              )),
                        ),
                        const SizedBox(
                          height: AppSizes.spaceBtwItems,
                        ),
                        GridLayout(
                          itemCount: products.length,
                          itemBuilder: (_, index) => ProductCardVertical(
                            product: products[index],
                          ),
                        )
                      ],
                    );
                  },
                )
              ],
            ),
          ),
        ]);
  }
}
