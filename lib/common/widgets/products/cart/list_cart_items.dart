import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../features/shop/controllers/product/cart_controller.dart';
import '../../../../utils/constants/sizes.dart';
import '../../texts/product_title_text.dart';
import 'add_remove_button.dart';
import 'cart_item.dart';

class ListCartItems extends StatelessWidget {
  const ListCartItems({super.key, this.showAddRemoveButtons = true});

  final bool showAddRemoveButtons;

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;

    return Obx(() {
      return ListView.separated(
          shrinkWrap: true,
          separatorBuilder: (context, index) => const SizedBox(
                height: AppSizes.spaceBtwItems,
              ),
          itemCount: controller.cartItems.length,
          itemBuilder: (context, index) => Obx(() {
                final item = controller.cartItems[index];
                return Column(
                  children: [
                    CartItem(
                      cartItem: item,
                    ),
                    if (showAddRemoveButtons)
                      const SizedBox(height: AppSizes.spaceBtwItems),
                    if (showAddRemoveButtons)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const SizedBox(
                                width: 70,
                              ),
                              AddRemoveButton(
                                quantity: item.quantity,
                                add: () => controller.addOneToCart(item),
                                remove: () => controller.removeOneToCart(item),
                              ),
                            ],
                          ),
                          ProductTitleText(title: (item.price*item.quantity).toStringAsFixed(1)),
                        ],
                      )
                  ],
                );
              }));
    });
  }
}
