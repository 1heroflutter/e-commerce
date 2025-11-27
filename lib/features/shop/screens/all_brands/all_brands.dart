import 'package:e_commerce_app/common/widgets/appbar/appbar.dart';
import 'package:e_commerce_app/common/widgets/loaders/brand_shimmer.dart';
import 'package:e_commerce_app/features/shop/controllers/brand_controller.dart';
import 'package:e_commerce_app/features/shop/screens/all_brands/brand_products.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/widgets/brand/brand_card.dart';
import '../../../../common/widgets/headings/section_headings.dart';
import '../../../../common/widgets/layouts/grid_layout.dart';

class AllBrandsScreen extends StatelessWidget {
  const AllBrandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;
    return Scaffold(
      appBar: const BasicAppBar(title: Text('Brand'), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.defaultSpace),
          child: Column(
            children: [
              // Heading
              const SectionHeading(title: 'Brands', showActionButton: false),
              const SizedBox(height: AppSizes.spaceBtwItems),

              // -- Brands
              Obx(() {
                if (controller.isLoading.value) {
                  return const BrandsShimmer();
                }
                if (controller.allBrands.isEmpty) {
                  return Center(
                    child: Text(
                      'No data found!',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  );
                }
                return GridLayout(
                  itemCount: controller.allBrands.length,
                  mainAxisExtent: 80,
                  itemBuilder: (_, index) {
                    final brand = controller.featuredBrands[index];
                    return BrandCard(
                      onTap: () =>Get.to(BrandProducts(brand: brand)),
                      showBorder: true,
                      brand: brand,
                    );
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