import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/common/widgets/appbar/appbar.dart';
import 'package:e_commerce_app/common/widgets/custom_shapes/curved_edges/curved_edge_widget.dart';
import 'package:e_commerce_app/common/widgets/products/favourite_icon/favourite_icon.dart';
import 'package:e_commerce_app/common/widgets/rounded_images/rounded_images.dart';
import 'package:e_commerce_app/features/shop/models/product_model.dart';
import 'package:e_commerce_app/utils/constants/colors.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utils/helpers/helper_functions.dart';
import '../../../controllers/product/image_controller.dart';

class ProductImageSlider extends StatelessWidget {
  final ProductModel product;

  const ProductImageSlider({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ImagesController());
    final images = controller.getAllProductImages(product);
    final dark = HelperFunctions.isDarkMode(context);
    return CurvedEdgesWidget(
        child: Container(
      color: dark ? AppColors.darkGrey : AppColors.light,
      child: Stack(
        children: [
          //Main large img
          SizedBox(
            height: 400,
            child: Padding(
              padding: EdgeInsets.all(AppSizes.productImageRadius * 2),
              child: Center(child: Obx(() {
                final image = controller.selectedProductImage.value;
                return GestureDetector(
                  onTap: () => controller.showEnlargedImage(image),
                  child: CachedNetworkImage(
                    imageUrl: image,
                    progressIndicatorBuilder: (context, url, progress) =>
                        CircularProgressIndicator(
                      value: progress.progress,
                      color: AppColors.primaryColor,
                    ),
                  ),
                );
              })),
            ),
          ),

          Positioned(
            right: 0,
            bottom: 30,
            left: AppSizes.defaultSpace,
            child: SizedBox(
              height: 80,
              child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => Obx(() {
                        final imageSelected =
                            controller.selectedProductImage.value ==
                                images[index];
                        return RoundedImage(
                            width: 80,
                            backgroundColor:
                                dark ? AppColors.darkGrey : AppColors.light,
                            border: imageSelected
                                ? Border.all(color: AppColors.primaryColor)
                                : Border.all(color: Colors.transparent),
                            padding: const EdgeInsets.all(AppSizes.sm),
                            isNetworkImage: true,
                            fit: BoxFit.fill,
                            onPressed: (){
                              controller.selectedProductImage.value = images[index];
                            },
                            imageUrl: images[index]);
                      }),
                  separatorBuilder: (context, index) => const SizedBox(
                        width: AppSizes.spaceBtwItems,
                      ),
                  itemCount: images.length),
            ),
          ),
          BasicAppBar(
            showBackArrow: true,
            actions: [
              FavouriteIcon(productId: product.id,)
            ],
          )
        ],
      ),
    ));
  }
}
