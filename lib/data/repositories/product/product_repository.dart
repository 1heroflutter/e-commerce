import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/common/widgets/exceptions/firebase_exception.dart';
import 'package:e_commerce_app/common/widgets/exceptions/platform_exception.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
// Đảm bảo bạn import đúng các file model, service và exception của mình
import 'package:e_commerce_app/features/shop/models/product_model.dart';
import 'package:e_commerce_app/data/services/storage_service.dart';

class ProductRepository extends GetxController {
  static ProductRepository get instance => Get.find();

  /// Firestore instance for database interactions.
  final _db = FirebaseFirestore.instance;
  Future<List<ProductModel>> getFeaturedProducts() async {
    try {
      final snapshot = await _db.collection('Products').where('IsFeatured', isEqualTo: true).limit(4).get();
      return snapshot.docs.map((e) => ProductModel.fromSnapshot(e)).toList();
    } on FirebaseException catch (e) {
      throw BasicFirebaseException(code:e.code).message;
    } on PlatformException catch (e) {
      throw BasicPlatformException(code:e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again ${e.toString()}';
    }
  }

  Future<List<ProductModel>> getAllFeaturedProducts() async {
    try {
      final snapshot = await _db.collection('Products').where('IsFeatured', isEqualTo: true).get();
      return snapshot.docs.map((e) => ProductModel.fromSnapshot(e)).toList();
    } on FirebaseException catch (e) {
      throw BasicFirebaseException(code:e.code).message;
    } on PlatformException catch (e) {
      throw BasicPlatformException(code:e.code).message;
    } catch (e) {

      throw 'Something went wrong. Please try again';
    }
  }
  /// Upload dummy data to the Cloud Firebase
  Future<void> uploadDummyData(List<ProductModel> products) async {
    try {
      final storage = Get.find<StorageService>();

      for (var product in products) {
        final thumbnail = await storage.getImageDataFromAssets(product.thumbnail);

        // Upload image and get its URL
        final url = await storage.uploadImageData(
            'Products/Images', thumbnail, product.thumbnail.toString());

        // Assign URL to product.thumbnail attribute
        product.thumbnail = url;

        // Product list of images
        if (product.images != null && product.images!.isNotEmpty) {
          List<String> imagesUrl = [];
          for (var image in product.images!) {
            // Get image data link from local assets
            final assetImage = await storage.getImageDataFromAssets(image);

            // Upload image and get its URL
            final url = await storage.uploadImageData('Products/Images', assetImage, image);

            imagesUrl.add(url);
          }
          product.images!.clear();
          product.images!.addAll(imagesUrl);
        }

        await _db.collection("Products").doc(product.id).set(product.toJson());
      }
    } on PlatformException catch (e) {
      throw BasicPlatformException(code:e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<List<ProductModel>> getProductsForBrand({required String brandId, int limit = -1}) async {
    try {
      final querySnapshot = limit == -1
          ? await _db.collection('Products').where('Brand.Id', isEqualTo: brandId).get()
          : await _db.collection('Products').where('Brand.Id', isEqualTo: brandId).limit(limit).get();

      final products = querySnapshot.docs.map((doc) => ProductModel.fromSnapshot(doc)).toList();
      return products;
    } on FirebaseException catch (e) {
      throw BasicFirebaseException(code:e.code).message;
    } on PlatformException catch (e) {
      throw BasicPlatformException(code:e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
  /// Get Products based on the Query
  Future<List<ProductModel>> getFavouriteProducts(List<String> productIds) async {
    try {
      final snapshot = await _db
          .collection('Products')
          .where(FieldPath.documentId, whereIn: productIds)
          .get();
      return snapshot.docs
          .map((querySnapshot) => ProductModel.fromSnapshot(querySnapshot))
          .toList();
    } on FirebaseException catch (e) {
      throw BasicFirebaseException( code: e.code).message;
    } on PlatformException catch (e) {
      throw BasicPlatformException( code: e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<List<ProductModel>> getProductsForCategory({required String categoryId, int limit = -1}) async {
    try {
      final productCategoryQuery = limit == -1
          ? await _db.collection('ProductCategory').where('categoryId', isEqualTo: categoryId).get()
          : await _db.collection('ProductCategory').where('categoryId', isEqualTo: categoryId).limit(limit).get();
      List<String> productIds = productCategoryQuery.docs.map((doc) => doc['productId'] as String).toList();

      print('--- [DEBUG] Đã tìm thấy ${productIds.length} ID sản phẩm: $productIds, ');
      if (productIds.isEmpty) {
        return [];
      }
      final productsQuery = await _db.collection('Products').where(FieldPath.documentId, whereIn: productIds).get();
      List<ProductModel> products = productsQuery.docs.map((doc) => ProductModel.fromSnapshot(doc)).toList();

      return products;
    } on FirebaseException catch (e) {
      throw BasicFirebaseException(code:e.code).message;
    } on PlatformException catch (e) {
      throw BasicPlatformException(code:e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}