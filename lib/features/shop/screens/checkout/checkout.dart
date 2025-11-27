import 'package:e_commerce_app/common/widgets/loaders/loaders.dart';
import 'package:e_commerce_app/features/shop/controllers/checkout_controller.dart';
import 'package:e_commerce_app/features/shop/controllers/product/cart_controller.dart';
import 'package:e_commerce_app/features/shop/screens/checkout/widgets/billing_address_section.dart';
import 'package:e_commerce_app/features/shop/screens/checkout/widgets/billing_amount_section.dart';
import 'package:e_commerce_app/features/shop/screens/checkout/widgets/billing_payment_section.dart';
import 'package:e_commerce_app/utils/constants/colors.dart';
import 'package:e_commerce_app/utils/helpers/pricing_calculator.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/common/widgets/appbar/appbar.dart';
import 'package:e_commerce_app/common/widgets/products/cart/list_cart_items.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:e_commerce_app/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../../common/widgets/products/cart/coupon_widget.dart';
import '../../controllers/order_controller.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    final controller = CartController.instance;
    final orderController = Get.put(OrderController());
    final checkoutController = CheckoutController.instance;
    final subTotal = controller.totalPrice.value;
    final totalAmount = PricingCalculator.calculateTotalPrice(subTotal,'VN');
    return Scaffold(
      appBar: BasicAppBar(
          showBackArrow: true,
          title: Text('Order Review',
              style: Theme.of(context).textTheme.headlineSmall)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.defaultSpace),
          child: Column(
            children: [
              // -- Items in Cart
              const ListCartItems(showAddRemoveButtons: false),
              const SizedBox(height: AppSizes.spaceBtwSections),
              // -- Payment
              const BillingPaymentSection(),
              const SizedBox(height: AppSizes.spaceBtwSections),

              // -- Coupon TextField
              const CouponWidget(),
              const SizedBox(height: AppSizes.spaceBtwSections),

              // -- Billing Section
              RoundedContainer(
                showBorder: true,
                padding: const EdgeInsets.all(AppSizes.md),
                backgroundColor: dark ? AppColors.black : AppColors.white,
                child: Column(
                  children: [
                    // Pricing
                    const BillingAmountSection(),
                    const SizedBox(height: AppSizes.spaceBtwItems),

                    // Divider
                    const Divider(),
                    const SizedBox(height: AppSizes.spaceBtwItems),

                    BillingAddressSection(),
                    // Address
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(AppSizes.defaultSpace),
        child: ElevatedButton(
          onPressed: subTotal > 0||orderController.addressController.selectedAddress.value.selectedAddress
              ? () => checkoutController.selectedPaymentMethod.value.name=="Paypal"? orderController.checkoutWithPaypal(totalAmount):orderController.processOrder(totalAmount, false)
              : () => Loaders.warningSnackBar(title: 'Empty Cart', message: 'Add items in the cart in order to proceed.'),
          child: Text('Checkout \$$totalAmount'),
        ),
      ),
    );
  }
}
