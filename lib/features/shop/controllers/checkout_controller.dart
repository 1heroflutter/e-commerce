import 'package:e_commerce_app/utils/constants/image_strings.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common/widgets/headings/section_headings.dart';
import '../models/payment_method_model.dart';
import '../screens/checkout/widgets/payment_tile.dart';

class CheckoutController extends GetxController {
  static CheckoutController get instance => Get.find();

  final Rx<PaymentMethodModel> selectedPaymentMethod = PaymentMethodModel.empty().obs;

  @override
  void onInit() {
    selectedPaymentMethod.value = PaymentMethodModel(name: 'Paypal', image: AppImages.paypal);
    super.onInit();
  }

  Future<dynamic> selectPaymentMethod(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (_) => SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(AppSizes.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionHeading(title: 'Select Payment Method', showActionButton: false),
              const SizedBox(height: AppSizes.spaceBtwSections),
              PaymentTile(paymentMethod: PaymentMethodModel(name: 'Paypal', image: AppImages.paypal,)),
              const SizedBox(height: AppSizes.spaceBtwItems / 2),
              PaymentTile(paymentMethod: PaymentMethodModel(name: 'Cash on delivery', image: AppImages.cashOnDelivery,)),
              const SizedBox(height: AppSizes.spaceBtwItems / 2),
            ],
          ),
        ),
      ),
    );
  }
}