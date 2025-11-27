import 'package:e_commerce_app/common/widgets/appbar/appbar.dart';
import 'package:e_commerce_app/common/widgets/loaders/animation_loader.dart';
import 'package:e_commerce_app/features/shop/controllers/order_controller.dart';
import 'package:e_commerce_app/navigation_menu.dart';
import 'package:e_commerce_app/utils/constants/app_animations.dart';
import 'package:e_commerce_app/utils/constants/colors.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:e_commerce_app/utils/helpers/cloud_helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../../utils/helpers/helper_functions.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    final controller = Get.put(OrderController());
    final navController = Get.find<NavigationController>();
    return Scaffold(
      appBar: BasicAppBar(
        title: Text(
          "My Orders",
          style: Theme
              .of(context)
              .textTheme
              .headlineSmall,
        ),
        showBackArrow: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(AppSizes.defaultSpace),
        child: FutureBuilder(
            future: controller.fetchUserOrders(),
            builder: (context, snapshot) {
              final emptyWidget = AnimationLoaderWidget(text: 'No orders yet!',
                animation: AppAnimations.empty_cart,
                showAction: true,
                actionText: 'Lets fill it',
                onActionPressed: () => navController.selectedIndex.value=1,);
              final response =CloudHelperFunctions.checkMultiRecordState(snapshot: snapshot,nothingFound: emptyWidget);
              if(response!=null) return response;
              final orders = snapshot.data!;
              return ListView.separated(
                shrinkWrap: true,
                itemCount: orders.length,
                separatorBuilder: (context, index) =>
                const SizedBox(
                  height: AppSizes.spaceBtwItems,
                ),
                itemBuilder: (context, index) {
                  final order = orders[index];
                  return RoundedContainer(
                    showBorder: true,
                    padding: const EdgeInsets.all(AppSizes.md),
                    backgroundColor: dark ? AppColors.dark : AppColors.light,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            // 1 - Icon
                            const Icon(Iconsax.ship),
                            const SizedBox(width: AppSizes.spaceBtwItems / 2),

                            // 2 - Status & Date
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    order.orderStatusText,
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .apply(
                                        color: AppColors.primaryColor,
                                        fontWeightDelta: 1),
                                  ),
                                  Text(order.formattedDeliveryDate,
                                      style: Theme
                                          .of(context)
                                          .textTheme
                                          .headlineSmall),
                                ],
                              ),
                            ),

                            // 3 - Icon
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(Iconsax.arrow_right_34,
                                    size: AppSizes.iconSm)),
                          ],
                        ),
                        const SizedBox(
                          height: AppSizes.spaceBtwItems,
                        ),
                        // Row 2
                        Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  // 1 - Icon
                                  const Icon(Iconsax.tag),
                                  const SizedBox(
                                      width: AppSizes.spaceBtwItems / 2),

                                  // 2 - Status & Date
                                  Expanded(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        Text('Order',
                                            style:
                                            Theme
                                                .of(context)
                                                .textTheme
                                                .labelMedium),
                                        Text(order.id,
                                            style:
                                            Theme
                                                .of(context)
                                                .textTheme
                                                .titleMedium),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  // 1 - Icon
                                  const Icon(Icons.payment_outlined),
                                  const SizedBox(
                                      width: AppSizes.spaceBtwItems / 2),

                                  // 2 - Status & Payment
                                  Expanded(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        Text('Payment',
                                            style:
                                            Theme
                                                .of(context)
                                                .textTheme
                                                .labelMedium),

                                        Text(order.isPaid?"Paid":"Un Paid",
                                            style:
                                            Theme
                                                .of(context)
                                                .textTheme
                                                .bodyMedium),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  );

                }
              );
            }
        ),
      ),
    );
  }
}
