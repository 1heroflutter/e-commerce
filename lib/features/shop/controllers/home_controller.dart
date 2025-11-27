import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/common/widgets/loaders/loaders.dart';
import 'package:e_commerce_app/features/shop/controllers/product/get_all_product_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../models/product_model.dart';
import '../screens/all_products/all_products.dart';

class HomeController extends GetxController{
  static HomeController get instance => Get.find();
  final carousalCurrentIndex = 0.obs;
  final search = TextEditingController(text: "");
  final AllProductsController allProductsController = Get.put(AllProductsController());
  void updatePageIndicator(index){
    carousalCurrentIndex.value = index;
  }

  void searchProducts() {
    final String searchText = search.text.trim();

    Query? productQuery;

    if (searchText.isNotEmpty) {
      final FirebaseFirestore db = FirebaseFirestore.instance;

      productQuery = db.collection('Products')
          .where('title', isGreaterThanOrEqualTo: searchText)
          .where('title', isLessThan: '$searchText\uf8ff');
    }

    if (productQuery != null) {
      Get.to(
        AllProductsScreen(
          title: 'Search results for: "$searchText"',
          query: productQuery,
        ),
      );
    } else {
      Loaders.errorSnackbar(title: 'Search failed', message: "Error while searching");
      allProductsController.products.clear();

    }
  }
}