import 'package:e_commerce_app/common/widgets/loaders/shimmer.dart';
import 'package:e_commerce_app/data/repositories/user/user_controller.dart';
import 'package:e_commerce_app/utils/constants/app_texts.dart';
import 'package:e_commerce_app/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../common/widgets/products/cart/cart_menu_icon.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return BasicAppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppTexts.homeAppBarTitle,
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .apply(color: AppColors.grey)),
          Obx(() {
            if (controller.profileLoading.value) {
              return  ShimmerEffect(width: 80, height: 15,color: AppColors.grey,);
            } else {
              return Text(controller.user.value.fullName,
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .apply(color: AppColors.white));
            }
          }),
        ],
      ),
      actions: [
        CartCounterIcon(
          iconColor: AppColors.white,
          onPressed: () {},
        ),
      ],
    );
  }
}
