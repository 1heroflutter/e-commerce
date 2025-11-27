import 'package:e_commerce_app/features/shop/controllers/favourites_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../icons/circular_icon.dart';

class FavouriteIcon extends StatelessWidget {
  final String productId;

  const FavouriteIcon({
    super.key,
    required this.productId,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FavouritesController());
    return Obx(() => CircularIcon(
        icon:
            controller.isFavourite(productId) ? Iconsax.heart5 : Iconsax.heart,
        color: controller.isFavourite(productId) ? Colors.red : null, onPressed: () => controller.toggleFavoriteProduct(
        productId),));
  }
}
