import 'package:e_commerce_app/data/repositories/user/user_controller.dart';
import 'package:e_commerce_app/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../features/personalization/screens/profile/profile.dart';
import '../../../utils/constants/image_strings.dart';
import '../images/circular_image.dart';

class UserSettingTile extends StatelessWidget {
  const UserSettingTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;

    return Obx(
        () {
          final networkImg = controller.user.value.profilePicture;
          final image = networkImg.isNotEmpty?networkImg:AppImages.lightAppLogo;
          return ListTile(
            leading: CircularImage(
              image: image, isNetworkImage: networkImg.isNotEmpty, ),
            title: Text(controller.user.value.fullName, style: Theme
                .of(context)
                .textTheme
                .headlineSmall!
                .apply(color: AppColors.white)),
            subtitle: Text(controller.user.value.email, style: Theme
                .of(context)
                .textTheme
                .bodyMedium!
                .apply(color: AppColors.white)),
            trailing: IconButton(onPressed: () => Get.to(() => ProfileScreen()),
                icon: const Icon(Iconsax.edit, color: AppColors.white)),
          );
        }
    );
  }
}