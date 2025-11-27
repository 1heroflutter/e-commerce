import 'package:e_commerce_app/utils/constants/app_animations.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common/widgets/headings/section_headings.dart';
import '../../../common/widgets/loaders/loaders.dart';
import '../../../data/repositories/address/address_repository.dart';
import '../../../utils/helpers/cloud_helper_function.dart';
import '../../../utils/network/network_manager.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../models/address_model.dart';
import '../screens/address/add_new_address.dart';
import '../screens/address/widgets/single_address.dart';

class AddressController extends GetxController {
  static AddressController get instance => Get.find();
  final name = TextEditingController();
  final phoneNumber = TextEditingController();
  final street = TextEditingController();
  final postalCode = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();
  final country = TextEditingController();
  GlobalKey<FormState> addressFormKey = GlobalKey<FormState>();
  RxBool refreshData = true.obs;
  final Rx<AddressModel> selectedAddress = AddressModel.empty().obs;
  final addressRepository = Get.put(AddressRepository());

  /// Fetch all user specific addresses
  Future<List<AddressModel>> getAllUserAddresses() async {
    try {
      final addresses = await addressRepository.fetchUserAddresses();
      selectedAddress.value = addresses.firstWhere((element) => element.selectedAddress, orElse: () => AddressModel.empty());
      return addresses;
    } catch (e) {
      Loaders.errorSnackbar(title: 'Address not found', message: e.toString());
      return [];
    }
  }

  Future selectAddress(AddressModel newSelectedAddress) async {
    try {
      // Clear the "selected" field
      if(selectedAddress.value.id.isNotEmpty){
        await addressRepository.updateSelectedField(selectedAddress.value.id, false);
      }

      // Assign selected address
      final updatedAddress = AddressModel(
        id: newSelectedAddress.id,
        name: newSelectedAddress.name,
        phoneNumber: newSelectedAddress.phoneNumber,
        street: newSelectedAddress.street,
        city: newSelectedAddress.city,
        state: newSelectedAddress.state,
        postalCode: newSelectedAddress.postalCode,
        country: newSelectedAddress.country,
        dateTime: newSelectedAddress.dateTime,
        selectedAddress: true, // <-- Đặt giá trị mới ở đây
      );
      selectedAddress.value = updatedAddress;

      // Set the "selected" field to true for the newly selected address
      await addressRepository.updateSelectedField(selectedAddress.value.id, true);
    } catch (e) {
      Loaders.errorSnackbar(title: 'Error in Selection', message: e.toString());
    }
  }

  Future addNewAddresses() async {
    try {
      // Start Loading
      FullScreenLoader.openLoadingDialog('Storing Address...', AppAnimations.loading_blue);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!addressFormKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();
        return;
      }

      // Save Address Data
      final address = AddressModel(
        id: '',
        name: name.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        street: street.text.trim(),
        city: city.text.trim(),
        state: state.text.trim(),
        postalCode: postalCode.text.trim(),
        country: country.text.trim(),
        selectedAddress: true,
      );

      final id = await addressRepository.addAddress(address);

      // Update Selected Address status
      address.id = id;
      await selectAddress(address);

      // Remove Loader
      FullScreenLoader.stopLoading();

      // Show Success Message
      Loaders.successSnackBar(title: 'Congratulations', message: 'Your address has been saved successfully.');

      // Refresh Addresses Data
      refreshData.toggle();

      // Reset fields
      resetFormFields();

      // Redirect
      Navigator.of(Get.context!).pop();
    } catch (e) {
      // Remove Loader
      FullScreenLoader.stopLoading();
      Loaders.errorSnackbar(title: 'Address not found', message: e.toString());
    }
  }

  /// Function to reset form fields
  void resetFormFields() {
    name.clear();
    phoneNumber.clear();
    street.clear();
    postalCode.clear();
    city.clear();
    state.clear();
    country.clear();
    addressFormKey.currentState?.reset();
  }
  /// Show Addresses ModalBottomSheet at Checkout
  Future<dynamic> selectNewAddressPopup(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (_) => Container(
        padding: const EdgeInsets.all(AppSizes.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeading(title: 'Select Address', showActionButton: false),
            FutureBuilder(
              future: getAllUserAddresses(),
              builder: (_, snapshot) {
                // Helper Function: Handle Loader, No Record, OR ERROR Message
                final response = CloudHelperFunctions.checkMultiRecordState(snapshot: snapshot);
                if (response != null) return response;

                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (_, index) => SingleAddress(
                    address: snapshot.data![index],
                    onTap: () async {
                      await selectAddress(snapshot.data![index]);
                      Get.back();
                    },
                  ),
                );
              }, // FutureBuilder
            ),
            const SizedBox(height: AppSizes.defaultSpace * 2),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: () => Get.to(() => const AddNewAddressScreen()), child: const Text('Add new address')),
            ),
          ],
        ), // Column
      ), // Container
    );
  }
}