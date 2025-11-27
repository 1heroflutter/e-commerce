import 'package:e_commerce_app/common/widgets/appbar/appbar.dart';
import 'package:e_commerce_app/common/widgets/products/cart/list_cart_items.dart';
import 'package:e_commerce_app/features/shop/controllers/product/cart_controller.dart';
import 'package:e_commerce_app/features/shop/screens/checkout/checkout.dart';
import 'package:e_commerce_app/navigation_menu.dart';
import 'package:e_commerce_app/utils/constants/app_animations.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    final navController = Get.find<NavigationController>();
    return Scaffold(
      appBar: BasicAppBar(
        showBackArrow: true,
        title: Text(
          'Cart',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: controller.cartItems.isEmpty
          ? Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                    Lottie.asset(AppAnimations.empty_cart,
                        width: MediaQuery.of(context).size.width * 0.8),
                  const SizedBox(height: AppSizes.spaceBtwItems,),
                  const Text('Your cart is empty'),
                  const SizedBox(height: AppSizes.spaceBtwItems,),
                  OutlinedButton(onPressed: () {
                    navController.selectedIndex.value = 0;
                    Get.offAll(() => NavigationMenu());
                  }, child: Text('Shop now!',style: Theme.of(context).textTheme.bodyLarge,))
                  ]),
          )
          : SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.all(AppSizes.defaultSpace),
                  child: ListCartItems()),
            ),
      bottomNavigationBar: controller.cartItems.isEmpty
          ? const SizedBox()
          : Padding(
              padding: const EdgeInsets.all(AppSizes.defaultSpace),
              child: ElevatedButton(
                  onPressed: () => Get.to(() => const CheckoutScreen()),
                  child: Obx(
                      () => Text('Checkout \$${controller.totalPrice.value}'))),
            ),
    );
  }
}
