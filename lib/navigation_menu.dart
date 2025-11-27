import 'package:e_commerce_app/features/shop/screens/home/home.dart';
import 'package:e_commerce_app/utils/constants/colors.dart';
import 'package:e_commerce_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'features/personalization/screens/settings/setting.dart';
import 'features/shop/screens/home/controllers/banner_controller.dart';
import 'features/shop/screens/store/screens/store/store.dart';
import 'features/shop/screens/wishlist/screens/favourite.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    Get.put(BannerController());

    final dark = HelperFunctions.isDarkMode(context);
    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
            height: 80,
            elevation: 0,
            selectedIndex: controller.selectedIndex.value,
            onDestinationSelected: (value) {
              controller.selectedIndex.value = value;
            },
            backgroundColor: dark?AppColors.black:AppColors.white,
            indicatorColor: dark?AppColors.white.withOpacity(0.1):AppColors.black.withOpacity(0.1),
            destinations: const [
              NavigationDestination(icon: Icon(Iconsax.home), label: "Home"),
              NavigationDestination(icon: Icon(Iconsax.shop), label: "Store"),
              NavigationDestination(
                  icon: Icon(Iconsax.heart), label: "Wishlist"),
              NavigationDestination(icon: Icon(Iconsax.user), label: "Profile"),
            ]),
      ),
      body: Obx(()=>controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;
  final screens = [
    HomeScreen(),
    StoreScreen(),
    FavouriteScreen(),
    SettingScreen()
  ];
}
