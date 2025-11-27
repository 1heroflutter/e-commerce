import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/common/widgets/exceptions/firebase_exception.dart';
import 'package:e_commerce_app/common/widgets/exceptions/platform_exception.dart';
import 'package:e_commerce_app/data/services/storage_service.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';

import '../../../features/shop/models/category_model.dart'; // Cần cho PlatformException

class CategoryRepository extends GetxController {
  static CategoryRepository get instance => Get.find();

  /// Variables
  final _db = FirebaseFirestore.instance;

  /// Get all categories
  Future<List<CategoryModel>> getAllCategories() async {
    try {
      final snapshot = await _db.collection('Categories').get();
      final list = snapshot.docs.map((document) => CategoryModel.fromSnapshot(document)).toList();
      return list;
    } on FirebaseException catch (e) {
      throw BasicFirebaseException(code: e.code).message;
    } on PlatformException catch (e) {
      throw BasicPlatformException(code: e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
  Future<List<CategoryModel>> getSubCategory(String categoryId) async {
    try {
      final snapshot = await _db.collection("Categories").where('ParentId', isEqualTo: categoryId).get();
      final result = snapshot.docs.map((e) => CategoryModel.fromSnapshot(e),).toList();
      return result;
    } on FirebaseException catch (e) {
      throw BasicFirebaseException(code:e.code).message;
    } on PlatformException catch (e) {
      throw BasicPlatformException(code: e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Upload Categories to the Cloud Firebase
  Future<void> uploadDummyData(List<CategoryModel> categories) async {
    try {
      final storage = Get.put(StorageService());

      for (var category in categories) {
        final file = await storage.getImageDataFromAssets(category.image);

        final url = await storage.uploadImageData('Categories', file, category.name);

        category.image = url;

        await _db.collection("Categories").doc(category.id).set(category.toJson());
      }
    } on FirebaseException catch (e) {
      throw BasicFirebaseException(code:e.code).message;
    } on PlatformException catch (e) {
      throw BasicPlatformException(code: e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}