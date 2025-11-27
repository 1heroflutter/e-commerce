import 'package:get/get.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter/material.dart';
import '../../../../common/widgets/loaders/loaders.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../../utils/constants/app_animations.dart';
import '../../../../data/services/paypal_service.dart';
import 'order_controller.dart';

class PaypalWebViewController extends GetxController {
  final String orderId;
  final double amount;

  PaypalWebViewController({required this.orderId, required this.amount});

  RxDouble progress = 0.0.obs;

  InAppWebViewController? webViewController;

  // Constants
  static const SUCCESS_REDIRECT = "myapp://paypal-success";
  static const CANCEL_REDIRECT = "myapp://paypal-cancel";

  // Hàm update progress
  void updateProgress(int p) {
    progress.value = p / 100;
  }

  Future<NavigationActionPolicy?> handleUrlLoading(NavigationAction action) async {
    final uri = action.request.url;
    if (uri == null) return NavigationActionPolicy.ALLOW;

    final url = uri.toString();
    print(" Navigating: $url");

    // --- SUCCESS REDIRECT ---
    if (url.startsWith(SUCCESS_REDIRECT)) {
      final payerId = uri.queryParameters["payerId"]; // Nhớ dùng chữ thường như đã fix
      final token = uri.queryParameters["token"];

      if (payerId != null && token != null) {
        _handlePaymentSuccess();
      }
      return NavigationActionPolicy.CANCEL;
    }

    // --- CANCEL REDIRECT ---
    if (url.startsWith(CANCEL_REDIRECT)) {
      Loaders.warningSnackBar(
          title: "Thanh toán bị huỷ",
          message: "Bạn đã huỷ thanh toán PayPal");
      Get.back(); // Thay cho Navigator.pop(context)
      return NavigationActionPolicy.CANCEL;
    }

    return NavigationActionPolicy.ALLOW;
  }

  // PAYMENT SUCCESS
  Future<void> _handlePaymentSuccess() async {
    final orderController = OrderController.instance;

    if (orderController.isOrderProcessing.value) return;
    orderController.isOrderProcessing.value = true;

    FullScreenLoader.openLoadingDialog("Đang xác nhận thanh toán...", AppAnimations.loading_blue);

    try {
      // Gọi Capture API
      final success = await PaypalService.captureOrder(orderId);

      if (success) {
        orderController.processOrder(amount, true);
      } else {
        Loaders.errorSnackbar(title: "PayPal Error", message: "Không capture được thanh toán.");
        Get.back();
      }
    } catch (e) {
      Loaders.errorSnackbar(title: "Lỗi PayPal", message: e.toString());
      Get.back();
    } finally {
      FullScreenLoader.stopLoading();
      orderController.isOrderProcessing.value = false;
    }
  }
}