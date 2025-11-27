import 'package:e_commerce_app/features/personalization/controllers/address_controller.dart';
import 'package:e_commerce_app/features/personalization/screens/address/widgets/single_address.dart';
import 'package:e_commerce_app/utils/helpers/cloud_helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import 'add_new_address.dart';

class UserAddressScreen extends StatelessWidget {
  const UserAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressController());
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        onPressed: () => Get.to(() => const AddNewAddressScreen()),
        child: const Icon(Iconsax.add, color: AppColors.white),
      ),
      appBar: BasicAppBar(
        showBackArrow: true,
        title:
            Text('Addresses', style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppSizes.defaultSpace),
          child: Obx(
              ()=> FutureBuilder(
              key:  Key(controller.refreshData.value.toString()),
              future: controller.getAllUserAddresses(),
              builder: (context, snapshot) {
                final response = CloudHelperFunctions.checkMultiRecordState(
                    snapshot: snapshot);
                if (response != null) return response;
                final addresses = snapshot.data!;

                return ListView.builder(
                    itemCount: addresses.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) => SingleAddress(
                          address: addresses[index],
                          onTap: () =>
                              controller.selectedAddress(addresses[index]),
                        ));
              },
            ),
          ),
        ),
      ),
    );
  }
}
