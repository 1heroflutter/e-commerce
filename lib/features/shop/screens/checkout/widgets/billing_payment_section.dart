import 'package:e_commerce_app/features/shop/controllers/checkout_controller.dart';
import 'package:e_commerce_app/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:e_commerce_app/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';
import '../../../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../../../common/widgets/headings/section_headings.dart';

class BillingPaymentSection extends StatelessWidget {
  const BillingPaymentSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    final controller = CheckoutController.instance;
    return Column(
      children: [
        SectionHeading(title: 'Payment Method', buttonTitle: 'Change', onPressed: ()=>controller.selectPaymentMethod(context)),
        const SizedBox(height: AppSizes.spaceBtwItems / 2),
        Obx(
          ()=> Row(
            children: [
              RoundedContainer(
                width: 60,
                height: 35,
                backgroundColor: dark ? AppColors.light : Colors.white,
                child:  Image(image: AssetImage(controller.selectedPaymentMethod.value.image), fit: BoxFit.contain),
              ),
              const SizedBox(width: AppSizes.spaceBtwItems / 2),
              Text(controller.selectedPaymentMethod.value.name, style: Theme.of(context).textTheme.bodyLarge),
            ],
          ),
        )
      ],
    );
  }
}