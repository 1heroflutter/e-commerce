import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce_app/common/widgets/custom_shapes/containers/custom_container.dart';
import 'package:e_commerce_app/common/widgets/loaders/shimmer.dart';
import 'package:e_commerce_app/features/shop/screens/home/controllers/banner_controller.dart';
import 'package:e_commerce_app/utils/constants/colors.dart';
import 'package:e_commerce_app/utils/device/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/rounded_images/rounded_images.dart';
import '../../../../../utils/constants/sizes.dart';

class PromoSlider extends StatelessWidget {
  const PromoSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BannerController>();
    return Obx(() {

      if (controller.isLoading.value) {
        return const ShimmerEffect(width: double.infinity, height: 190);
      }
      if (controller.banners.isEmpty) {
        return const Center(
          child: Text('No Data Found'),
        );
      } else {
        return Column(
          children: [
            CarouselSlider(
                options: CarouselOptions(
                  viewportFraction: 1,
                  onPageChanged: (index, _) =>
                      controller.updatePageIndicator(index),
                ),
              items: controller.banners.map((banner) {
                final bool isNetwork = banner.imageUrl.isNotEmpty &&
                    banner.imageUrl.startsWith('http');

                return RoundedImage(
                  imageUrl: banner.imageUrl,
                  width: DeviceUtils.getScreenWidth(context) * 0.86,
                  isNetworkImage: isNetwork,
                  onPressed: () {},
                );
              }).toList(),
            ),
            const SizedBox(
              height: AppSizes.spaceBtwItems,
            ),
            Center(
              child: Obx(
                () => Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (int i = 0; i < controller.banners.length; i++)
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: CircularContainer(
                          width: 20,
                          height: 4,
                          margin: EdgeInsets.only(right: 10),
                          backgroundColor:
                              controller.carousalCurrentIndex.value == i
                                  ? AppColors.primaryColor
                                  : AppColors.grey,
                        ),
                      )
                  ],
                ),
              ),
            )
          ],
        );
      }
    });
  }
}
