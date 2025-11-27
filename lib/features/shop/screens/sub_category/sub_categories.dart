import 'package:e_commerce_app/common/widgets/appbar/appbar.dart';
import 'package:e_commerce_app/common/widgets/loaders/shimmer.dart';
import 'package:e_commerce_app/common/widgets/products/product_cards/product_card_horizontal.dart';
import 'package:e_commerce_app/features/shop/controllers/category_controller.dart';
import 'package:e_commerce_app/features/shop/models/category_model.dart';
import 'package:e_commerce_app/features/shop/screens/all_products/all_products.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:e_commerce_app/utils/helpers/cloud_helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/headings/section_headings.dart';
import '../../../../common/widgets/rounded_images/rounded_images.dart';

class SubCategoriesScreen extends StatelessWidget {
  final CategoryModel category;

  const SubCategoriesScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    return Scaffold(
      appBar: BasicAppBar(title: Text(category.name), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.defaultSpace),
          child: Column(
            children: [
              // Banner
              RoundedImage(
                  width: double.infinity,
                  imageUrl: category.image,
                  isNetworkImage: true,
                  applyImageRadius: true),
              const SizedBox(height: AppSizes.spaceBtwSections),

              // Sub-Categories
              FutureBuilder(
                  future: controller.getSubCategories(category.id),
                  builder: (context, asyncSnapshot) {
                    final loader =
                        ShimmerEffect(width: double.infinity, height: 50);
                    final widget = CloudHelperFunctions.checkMultiRecordState(
                        snapshot: asyncSnapshot, loader: loader);
                    if (widget != null) return widget;
                    final subCategories = asyncSnapshot.data!;

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: subCategories.length,
                      itemBuilder: (BuildContext context, int index) {

                        final subcategory = subCategories[index];
                        print('-----------SUBCATEGORY ID-----------: ${{
                          subcategory.id
                        }}');
                        return FutureBuilder(
                            future: controller.getCategoryProducts(
                                categoryId: subcategory.id),
                            builder: (context, asyncSnapshot) {
                              final widget = CloudHelperFunctions.checkMultiRecordState(
                                  snapshot: asyncSnapshot, loader: loader);
                              if (widget != null) return widget;
                              final products = asyncSnapshot.data!;

                              return Column(
                                children: [
                                  // Heading
                                  SectionHeading(
                                    title: subcategory.name,
                                    onPressed: () =>
                                        Get.to(() => AllProductsScreen(
                                              title: subcategory.name,
                                              futureMethod: () => controller
                                                  .getCategoryProducts(
                                                      categoryId:
                                                          subcategory.id,
                                                      limit: -1),
                                            )),
                                  ),
                                  const SizedBox(
                                      height: AppSizes.spaceBtwItems / 2),

                                  SizedBox(
                                    height: 120,
                                    child: ListView.separated(
                                      itemCount: products.length,
                                      scrollDirection: Axis.horizontal,
                                      separatorBuilder: (context, index) =>
                                          const SizedBox(
                                              width: AppSizes.spaceBtwItems),
                                      itemBuilder: (context, index) =>
                                          ProductCardHorizontalWidget(
                                        product: products[index],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            });
                      },
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
