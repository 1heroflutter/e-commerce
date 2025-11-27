import 'package:e_commerce_app/features/shop/controllers/product/cart_controller.dart';
import 'package:e_commerce_app/features/shop/screens/checkout/paypal_webview_screen.dart';
import 'package:e_commerce_app/navigation_menu.dart';
import 'package:e_commerce_app/utils/constants/app_animations.dart';
import 'package:e_commerce_app/utils/constants/image_strings.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../common/widgets/loaders/loaders.dart';
import '../../../common/widgets/success_screen/success_screen.dart';
import '../../../data/repositories/authentication/authentication_repository.dart';
import '../../../data/repositories/order/order_repository.dart';
import '../../../data/services/paypal_service.dart';
import '../../../data/services/vnpay_service.dart';
import '../../../utils/constants/enums.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../../personalization/controllers/address_controller.dart';
import '../models/order_model.dart';
import 'checkout_controller.dart';

class OrderController extends GetxController {
  static OrderController get instance => Get.find();

  // Variables
  final cartController = CartController.instance;
  final addressController = AddressController.instance;
  final checkoutController = CheckoutController.instance;
  final orderRepository = Get.put(OrderRepository());
  final isOrderProcessing = false.obs;
  /// Fetch user's order history
  Future<List<OrderModel>> fetchUserOrders() async {
    try {
      final userOrders = await orderRepository.fetchUserOrders();
      return userOrders;
    } catch (e) {
      Loaders.warningSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }

  Future<void> checkoutWithPaypal(double totalAmount) async {
    try {
      FullScreenLoader.openLoadingDialog(
        'Redirecting to PayPal...',
        AppAnimations.loading_blue,
      );

      final paypalOrder = await PaypalService.createOrder(totalAmount);

      FullScreenLoader.stopLoading();

      await Get.to(() => PaypalWebViewScreen(
        checkoutUrl: paypalOrder.approveUrl,
        orderId: paypalOrder.orderId,
        amount: totalAmount,
      ));
    } catch (e) {
      FullScreenLoader.stopLoading();
      Loaders.errorSnackbar(title: 'PayPal Error', message: e.toString());
      print( '[DEBUG] ${ e.toString()}', );
    }
  }
  /// Add methods for order processing
  void processOrder(double totalAmount, bool isPaid) async {
    try {
      // Start Loader
      FullScreenLoader.openLoadingDialog('Processing your order', AppAnimations.loading_blue);

      // Get user authentication Id
      final userId = AuthenticationRepository.instance.authUser!.uid;
      if (userId.isEmpty) return;

      // Add Details
      final order = OrderModel(
        // Generate a unique ID for the order
        id: UniqueKey().toString(),
        userId: userId,
        status: OrderStatus.processing,
        totalAmount: totalAmount,
        orderDate: DateTime.now(),
        paymentMethod: checkoutController.selectedPaymentMethod.value.name,
        isPaid: isPaid,
        address: addressController.selectedAddress.value,
        // Set Date as needed
        deliveryDate: DateTime.now(),
        items: cartController.cartItems.toList(),
      );

      // Save the order to Firestore
      await orderRepository.saveOrder(order, userId);

      // Update the cart status
      cartController.clearCart();
      
      // Show Success screen
      Get.offAll(() => SuccessScreen(
        image: AppImages.successfulPaymentIcon,
        title: 'Payment Success!',
        subTitle: 'Your item will be shipped soon!',
        onPressed: () => Get.offAll(() => const NavigationMenu()),
      ));
    } catch (e) {
      Loaders.errorSnackbar(title: 'Oh Snap', message: e.toString());
    }
  }
}