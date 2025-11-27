import 'package:e_commerce_app/common/widgets/exceptions/firebase_exception.dart';
import 'package:e_commerce_app/common/widgets/exceptions/platform_exception.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../data/repositories/product/product_repository.dart';
import '../../models/product_model.dart';

class AllProductsController extends GetxController {
  static AllProductsController get instance => Get.find();

  final repository = Get.put(ProductRepository());

  final RxList<ProductModel> products = <ProductModel>[].obs;
  final RxString selectedSortOption = 'Name'.obs;
  final isLoading = false.obs;

  Future<List<ProductModel>> fetchProductsByQuery(Query? query) async {
    try {
      if (query == null) {
        return [];
      }
      final querySnapshot = await query.get();

      final List<ProductModel> productList = querySnapshot.docs.map((doc) => ProductModel.fromQuerySnapshot(doc)).toList();

      return productList;
    } on FirebaseException catch (e) {
      throw BasicFirebaseException(code:e.code).message;
    } on PlatformException catch (e) {
      throw BasicPlatformException(code:e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
  void sortProducts(String sortOption) {
    selectedSortOption.value = sortOption;

    switch (sortOption) {
      case 'Name':
        products.sort((a, b) => a.title.compareTo(b.title));
        break;
      case 'Higher Price':
        products.sort((a, b) => b.price.compareTo(a.price));
        break;
      case 'Lower Price':
        products.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'Newest':
        products.sort((a, b) => (a.date??DateTime.now()).compareTo(b.date??DateTime.now()));
        break;
      case 'Sale':
        products.sort((a, b) {
          if (b.salePrice > 0) {
            return b.salePrice.compareTo(a.salePrice);
          } else if (a.salePrice > 0) {
            return -1;
          } else {
            return 1;
          }
        });
        break;
      default:
      // Default sorting option: Name
        products.sort((a, b) => a.title.compareTo(b.title));
    }
  }
  void assignProducts(List<ProductModel> products) {
    this.products.assignAll(products);
    sortProducts('Name');
  }
}