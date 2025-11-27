import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:e_commerce_app/common/widgets/loaders/loaders.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
class NetworkManager extends GetxController {
  static NetworkManager get instance => Get.find();

  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
  final Rx<ConnectivityResult> _connectionStatus = ConnectivityResult.none.obs;

  @override
  void onInit() {
    super.onInit();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  /// Update the connection status based on changes in connectivity and show a relevant popup for no internet connection.
  Future<void> _updateConnectionStatus(List<ConnectivityResult> resultList) async {

    // Bạn chỉ offline khi danh sách chỉ có 1 phần tử là 'none'.
    if (resultList.length == 1 && resultList[0] == ConnectivityResult.none) {
      _connectionStatus.value = ConnectivityResult.none;
      Loaders.warningSnackBar(title: 'No Internet Connection');
    } else {
      // Nếu có kết nối, ưu tiên lưu trữ kết nối "tốt nhất" (ví dụ: Wifi > Mobile)
      if (resultList.contains(ConnectivityResult.wifi)) {
        _connectionStatus.value = ConnectivityResult.wifi;
      } else if (resultList.contains(ConnectivityResult.mobile)) {
        _connectionStatus.value = ConnectivityResult.mobile;
      } else {
        // Nếu không phải wifi hay mobile (ví dụ: ethernet, vpn), cứ lấy phần tử đầu tiên
        _connectionStatus.value = resultList.first;
      }
    }
  }

  /// Check the internet connection status.
  /// Returns `true` if connected, `false` otherwise.
  Future<bool> isConnected() async {
    try {
      final resultList = await _connectivity.checkConnectivity();

      // Nếu danh sách chỉ có 1 phần tử là 'none', thì return false.
      if (resultList.length == 1 && resultList[0] == ConnectivityResult.none) {
        return false;
      } else {
        // Bất kỳ trường hợp nào khác (có wifi, có mobile, hoặc cả 2) đều là 'true'
        return true;
      }
    } on PlatformException catch (_) {
      return false;
    }
  }

  @override
  void onClose() {
    super.onClose();
    _connectivitySubscription.cancel();
  }
}