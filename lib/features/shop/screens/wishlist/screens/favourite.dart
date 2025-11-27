import 'package:e_commerce_app/common/widgets/loaders/animation_loader.dart';
import 'package:e_commerce_app/common/widgets/loaders/vertical_product_shimmer.dart';
import 'package:e_commerce_app/features/shop/controllers/favourites_controller.dart';
import 'package:e_commerce_app/navigation_menu.dart';
import 'package:e_commerce_app/utils/constants/app_animations.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:e_commerce_app/utils/helpers/cloud_helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/widgets/icons/circular_icon.dart';
import '../../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../../common/widgets/products/product_cards/product_card_vertical.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FavouritesController());
    final navController = Get.find<NavigationController>();
    return Scaffold(
      appBar: AppBar(
        title:
            Text('Wishlist', style: Theme.of(context).textTheme.headlineMedium),
        actions: [
          CircularIcon(
              icon: Iconsax.add, onPressed: () => navController.selectedIndex.value=1),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.defaultSpace),
          child: Column(
            children: [
              Obx(() {

                return FutureBuilder(
                    future: controller.favoriteProducts(),
                    builder: (context, asyncSnapshot) {
                      final loader = VerticalProductShimmer(
                        itemCount: 6,
                      );

                      final widget = CloudHelperFunctions.checkMultiRecordState(
                          snapshot: asyncSnapshot,
                          loader: loader,
                          nothingFound: AnimationLoaderWidget(
                            text: "Your wishlist is empty.",
                            showAction: true,
                            animation: AppAnimations.empty_cart,
                            onActionPressed: () =>
                                navController.selectedIndex.value=0,
                            actionText: 'Let\'s add some',
                          ));
                      if (widget != null) return widget;

                      final products = asyncSnapshot.data!;

                      return GridLayout(
                          itemCount: products.length,
                          itemBuilder: (_, index) => ProductCardVertical(
                            product: products[index],
                          ));
                    });
              }),
            ],
          ),
        ),
      ),
    );
  }
}
