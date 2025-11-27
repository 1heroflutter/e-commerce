import 'package:e_commerce_app/common/widgets/headings/section_headings.dart';
import 'package:e_commerce_app/common/widgets/layouts/grid_layout.dart';
import 'package:e_commerce_app/features/shop/controllers/home_controller.dart';
import 'package:e_commerce_app/features/shop/controllers/product/product_controllers.dart';
import 'package:e_commerce_app/features/shop/screens/all_products/all_products.dart';
import 'package:e_commerce_app/features/shop/screens/home/widgets/home_appbar.dart';
import 'package:e_commerce_app/features/shop/screens/home/widgets/home_categories.dart';
import 'package:e_commerce_app/features/shop/screens/home/widgets/promo_slider.dart';
import 'package:e_commerce_app/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/widgets/custom_shapes/containers/primary_header_container.dart';
import '../../../../common/widgets/custom_shapes/containers/search_container.dart';
import '../../../../common/widgets/loaders/vertical_product_shimmer.dart';
import '../../../../common/widgets/products/product_cards/product_card_vertical.dart';
import '../../../../utils/constants/sizes.dart';
import '../../controllers/product/get_all_product_controller.dart';

class HomeScreen extends StatelessWidget {
   const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
    final homeController = Get.put(HomeController());
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(children: [
      PrimaryHeaderContainer(
        child: Column(
          children: [
            HomeAppBar(),
            const SizedBox(
              height: AppSizes.spaceBtwSections,
            ),
            SearchContainer(text: "Search in Store", controller: homeController.search,searchProduct: homeController.searchProducts, ),
            const SizedBox(
              height: AppSizes.spaceBtwSections,
            ),
            Padding(
              padding: const EdgeInsets.only(left: AppSizes.defaultSpace),
              child: Column(
                children: [
                  SectionHeading(
                    title: "Popular Categories",
                    textColor: AppColors.white,
                    showActionButton: false,
                  ),
                  const SizedBox(
                    height: AppSizes.spaceBtwItems,
                  ),
                  HomeCategories(),
                  const SizedBox(
                    height: AppSizes.spaceBtwSections,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      Padding(
        padding: EdgeInsetsGeometry.all(AppSizes.defaultSpace),
        child: Column(
          children: [
            PromoSlider(),
            const SizedBox(
              height: AppSizes.spaceBtwSections,
            ),
            SectionHeading(
              title: 'Popular Products',
              onPressed: () => Get.to(() => AllProductsScreen(
                title: 'Popular Products',
                futureMethod: controller.fetchAllFeaturedProducts,
              )),
            ),
            const SizedBox(
              height: AppSizes.spaceBtwItems,
            ),
            Obx(() {
              if (controller.isLoading.value) {
                return const VerticalProductShimmer();
              }

              if (controller.featuredProducts.isEmpty) {
                return Center(
                    child: Text('No Data Found!',
                        style: Theme.of(context).textTheme.bodyMedium));
              }

              return GridLayout(
                itemCount: controller.featuredProducts.length,
                itemBuilder: (_, index) => ProductCardVertical(
                    product: controller.featuredProducts[index]),
              );
            })
          ],
        ),
      ),
    ])));
  }
}
