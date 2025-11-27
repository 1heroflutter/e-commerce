import 'package:e_commerce_app/common/widgets/appbar/appbar.dart';
import 'package:e_commerce_app/common/widgets/appbar/tabbar.dart';
import 'package:e_commerce_app/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:e_commerce_app/common/widgets/headings/section_headings.dart';
import 'package:e_commerce_app/common/widgets/layouts/grid_layout.dart';
import 'package:e_commerce_app/common/widgets/loaders/brand_shimmer.dart';
import 'package:e_commerce_app/common/widgets/products/cart/cart_menu_icon.dart';
import 'package:e_commerce_app/features/shop/controllers/brand_controller.dart';
import 'package:e_commerce_app/features/shop/controllers/category_controller.dart';
import 'package:e_commerce_app/features/shop/screens/all_brands/all_brands.dart';
import 'package:e_commerce_app/features/shop/screens/all_brands/brand_products.dart';
import 'package:e_commerce_app/features/shop/screens/store/screens/store/widgets/category_tab.dart';
import 'package:e_commerce_app/utils/constants/colors.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:e_commerce_app/utils/device/device_utils.dart';
import 'package:e_commerce_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../common/widgets/brand/brand_card.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BrandController());
    final categories = CategoryController.instance.featuredCategories;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(DeviceUtils.getScreenWidth(context), 80),
        child: BasicAppBar(
          title:
              Text('Store', style: Theme.of(context).textTheme.headlineMedium),
          actions: [
            CartCounterIcon(
              onPressed: () {},
              iconColor: HelperFunctions.isDarkMode(context)
                  ? AppColors.white
                  : AppColors.black,
            ),
          ],
        ),
      ),
      body: DefaultTabController(
        length: categories.length,
        child: NestedScrollView(
          headerSliverBuilder: (_, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                automaticallyImplyLeading: false,
                floating: true,
                pinned: true,
                backgroundColor: HelperFunctions.isDarkMode(context)
                    ? AppColors.black
                    : AppColors.white,
                expandedHeight: 440,
                flexibleSpace: Padding(
                  padding: const EdgeInsets.all(AppSizes.defaultSpace),
                  child: ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      const SizedBox(height: AppSizes.spaceBtwItems),
                       SearchContainer(
                        text: 'Search in Store',
                        showBorder: true,
                        controller: TextEditingController(),
                        showBackground: false,
                        padding: EdgeInsets.zero,
                      ),
                      const SizedBox(height: AppSizes.spaceBtwSections),
                      SectionHeading(
                        title: "Featured Brands",
                        onPressed: () => Get.to(() => AllBrandsScreen()),
                      ),
                      const SizedBox(height: AppSizes.spaceBtwItems / 1.5),
                      Obx(() {
                        if (controller.isLoading.value) {
                          return const BrandsShimmer();
                        }
                        if (controller.featuredBrands.isEmpty) {
                          return Center(
                            child: Text(
                              'No data found!',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          );
                        }
                        return GridLayout(
                          itemCount: controller.featuredBrands.length,
                          mainAxisExtent: 80,
                          itemBuilder: (_, index) {
                            final brand = controller.featuredBrands[index];
                            return BrandCard(
                              onTap: () => Get.to(()=> BrandProducts(brand: brand)),
                              showBorder: false,
                              brand: brand,
                            );
                          },
                        );
                      }),
                      const SizedBox(height: AppSizes.spaceBtwSections),
                    ],
                  ),
                ),
                bottom: BasicTabBar(
                    tabs: categories
                        .map(
                          (element) => Tab(
                            child: Text(element.name,maxLines: 1,),
                          ),
                        )
                        .toList()),
              ),
            ];
          },
          body: TabBarView(
              children: categories
                  .map(
                    (element) => CategoryTab(
                      category: element,
                    ),
                  )
                  .toList()),
        ),
      ),
    );
  }
}
