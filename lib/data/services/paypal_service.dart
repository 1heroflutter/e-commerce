import 'dart:convert';
import 'package:e_commerce_app/utils/constants/api_constants.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../features/shop/models/paypal_order_model.dart';

class PaypalService {
  static const String baseUrl = APIConstants.paypalBaseUrl;

  /// Create PayPal order
  static Future<PaypalOrderModel> createOrder(double amount) async {
    print("DEBUG URL CALL: $baseUrl/create-order");
    final response = await http.post(
      Uri.parse("$baseUrl/create-order"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "amount": amount,
        "currency": "USD",
      }),
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to create PayPal order");
    }

    final json = jsonDecode(response.body);
    return PaypalOrderModel.fromJson(json);
  }

  /// Capture order after success
  static Future<bool> captureOrder(String orderId) async {
    final url = Uri.parse("$baseUrl/capture-order");

    // 1. Log URL và dữ liệu gửi đi (Chỉ dùng khi debug)
    if (kDebugMode) {
      print('>>> [API] Bắt đầu gọi Capture Order: $orderId tại $url');
    }

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"orderId": orderId}),
      ).timeout(const Duration(seconds: 30)); // Thêm timeout để tránh bị treo vĩnh viễn

      // 2. Kiểm tra mã trạng thái HTTP
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print('>>> [API] Capture Order thành công. Mã 200.');
        }
        return true;
      } else {
        // 3. Xử lý lỗi (Mã trạng thái khác 200)
        final errorJson = jsonDecode(response.body);
        final errorMessage = errorJson['details'] ?? errorJson['error'] ?? 'Lỗi không xác định từ Server.';

        if (kDebugMode) {
          print('>>> [API ERROR] Capture thất bại: Mã ${response.statusCode}, Chi tiết: $errorMessage');
        }

        // Ném Exception chi tiết để _handlePaymentSuccess bắt được
        throw Exception("Capture thất bại (Mã ${response.statusCode}): $errorMessage");
      }
    } on http.ClientException {
      // Lỗi mạng hoặc HTTP client, ví dụ: DNS lookup failed
      throw Exception("Lỗi kết nối mạng: Không thể kết nối đến $baseUrl");
    } on FormatException {
      // Lỗi định dạng JSON
      throw Exception("Server trả về dữ liệu không đúng định dạng.");
    } on Exception catch (e) {
      // Bắt các lỗi khác (bao gồm TimeoutException)
      if (kDebugMode) {
        print('>>> [CAPTURE EXCEPTION] Lỗi: $e');
      }
      rethrow;
    }
  }
}
