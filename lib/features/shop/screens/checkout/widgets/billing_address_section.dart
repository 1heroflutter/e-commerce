import 'package:e_commerce_app/features/personalization/controllers/address_controller.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/headings/section_headings.dart';

class BillingAddressSection extends StatelessWidget {
  const BillingAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AddressController.instance;
    return Obx(
      ()=> Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeading(
            title: 'Shipping Address',
            buttonTitle: 'Change',
            onPressed: () => controller.selectNewAddressPopup(context),
          ),
          controller.selectedAddress.value.id.isNotEmpty?
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(controller.selectedAddress.value.name.toString(),
                  style: Theme.of(context).textTheme.bodyLarge),
              const SizedBox(height: AppSizes.spaceBtwItems / 2),
              Row(
                children: [
                  const Icon(Icons.phone, color: Colors.grey, size: 16),
                  const SizedBox(width: AppSizes.spaceBtwItems),
                  Text(controller.selectedAddress.value.phoneNumber.toString(),
                      style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
              const SizedBox(height: AppSizes.spaceBtwItems / 2),
              Row(
                children: [
                  const Icon(Icons.location_history, color: Colors.grey, size: 16),
                  const SizedBox(width: AppSizes.spaceBtwItems),
                  Expanded(
                      child: Text(controller.selectedAddress.value.toString(),
                          style: Theme.of(context).textTheme.bodyMedium,
                          softWrap: true)),
                ],
              ),
            ],
          ):Text('Select Address', style: Theme.of(context).textTheme.bodyMedium,)
        ],
      ),
    );
  }
}
