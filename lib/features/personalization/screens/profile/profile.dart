import 'package:e_commerce_app/common/widgets/appbar/appbar.dart';
import 'package:e_commerce_app/data/repositories/user/user_controller.dart';
import 'package:e_commerce_app/features/personalization/screens/profile/change_name.dart';
import 'package:e_commerce_app/features/personalization/screens/profile/widgets/profile_menu.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/headings/section_headings.dart';
import '../../../../common/widgets/images/circular_image.dart';
import '../../../../utils/constants/image_strings.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: const BasicAppBar(showBackArrow: true, title: Text('Profile')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.defaultSpace),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [

                     Obx(() {
                       final networkImg = controller.user.value.profilePicture;
                       final image = networkImg.isNotEmpty?networkImg:AppImages.lightAppLogo;
                       return CircularImage(
                           image: image, width: 80, height: 80, isNetworkImage: networkImg.isNotEmpty,);
                     }),
                    TextButton(onPressed: () => controller.uploadUserProfilePicture(), child: const Text('Change Profile Picture')),
                  ],
                ),
              ),
              const SizedBox(height: AppSizes.spaceBtwItems / 2),
              const Divider(),
              const SizedBox(height: AppSizes.spaceBtwItems),
              const SectionHeading(title: 'Profile Information'),
              const SizedBox(height: AppSizes.spaceBtwItems),

              ProfileMenu(title: 'Name', value:controller.user.value.lastName , onPressed:() =>  Get.to(()=>ChangeName()),),
              ProfileMenu(title: 'Username', value:controller.user.value.username , onPressed: () {}),

              const SizedBox(height: AppSizes.spaceBtwItems),
              const Divider(),
              const SizedBox(height: AppSizes.spaceBtwItems),

              const SectionHeading(title: 'Personal Information', showActionButton: false),
              const SizedBox(height: AppSizes.spaceBtwItems),

              ProfileMenu(title: 'User ID', value: controller.user.value.id, icon: Iconsax.copy, onPressed: () {}),
              ProfileMenu(title: 'E-mail', value: controller.user.value.email, onPressed: () {}),
              ProfileMenu(title: 'Phone Number', value: controller.user.value.phoneNumber, onPressed: () {}),
              ProfileMenu(title: 'Gender', value: 'Male', onPressed: () {}),
              ProfileMenu(title: 'Date of Birth', value: '10 Oct, 1994', onPressed: () {}),
              const Divider(),
              const SizedBox(height: AppSizes.spaceBtwItems),

              Center(
                child: TextButton(
                  onPressed:() =>  controller.deleteAccountWarningPopup(),
                  child: const Text('Close Account', style: TextStyle(color: Colors.red)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}