import 'dart:convert';
import 'package:e_commerce_app/utils/constants/api_constants.dart';
import 'package:http/http.dart' as http;

class VnPayService {
  static const String baseUrl =APIConstants.vnpayBaseUrl;

  static Future<String> createPaymentUrl({
    required String orderId,
    required double amount,
    String orderInfo = "Thanh toan mua hang",
  }) async {
    final response = await http.post(
      Uri.parse("$baseUrl/create_payment_url"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "orderId": orderId,
        "amount": amount*25,
        "orderInfo": orderInfo,
        "bankCode": "NCB"
      }),
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return json['paymentUrl'];
    } else {
      throw Exception("Failed to generate VNPay URL");
    }
  }
}