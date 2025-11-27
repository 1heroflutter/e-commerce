import 'package:e_commerce_app/common/widgets/appbar/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../../../common/widgets/loaders/loaders.dart';
import 'package:get/get.dart';

import '../../controllers/paypal_webview_controller.dart';

class PaypalWebViewScreen extends StatelessWidget {
  final String checkoutUrl;
  final String orderId;
  final double amount;

  const PaypalWebViewScreen({
    super.key,
    required this.checkoutUrl,
    required this.orderId,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    // Khởi tạo Controller và truyền tham số vào
    final controller = Get.put(PaypalWebViewController(
        orderId: orderId,
        amount: amount
    ));

    return Scaffold(
      appBar: BasicAppBar(title: const Text("Paypal Payment")),
      body: Stack(
        children: [
          InAppWebView(
            initialUrlRequest: URLRequest(
              url: WebUri(checkoutUrl),
            ),

            // Gán controller
            onWebViewCreated: (webController) {
              controller.webViewController = webController;
            },

            onProgressChanged: (webController, progress) {
              controller.updateProgress(progress);
            },

            shouldOverrideUrlLoading: (webController, action) {
              return controller.handleUrlLoading(action);
            },

            onLoadError: (webController, request, code, message) {
              Loaders.errorSnackbar(
                  title: "Loading error",
                  message: message ?? "Unknown error");
              Get.back();
            },
          ),

          Obx(
                () => controller.progress.value < 1.0
                ? LinearProgressIndicator(value: controller.progress.value)
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}